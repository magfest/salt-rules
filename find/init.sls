find-prereqs:
  pkg.installed:
    - names:
      - golang
      - git
      - mosquitto

find-git:
  git.latest:
    - name: https://github.com/schollz/find.git
    - target: /opt/go/find
    - require:
      - pkg: find-prereqs

/opt/go/find:
  file.directory:
    - makedirs: True

build-find:
  cmd.run:
    - env:
      - GOPATH: /opt/go
    - name: go get ./... && go build
    - cwd: /opt/go/find
    - require:
      - git: find-git
      - pkg: find-prereqs
      - file: /opt/go/find
    - onchanges:
      - git: find-git

/opt/go/find/mosquitto/conf:
  file.managed:
    - makedirs: True
    - replace: False
    - contents: ''

/etc/mosquitto/mosquitto.conf:
  file.symlink:
    - target: /opt/go/find/mosquitto/conf
    - force: True
    - require:
      - pkg: find-prereqs

mosquitto:
  service.running:
    - enable: True
    - require:
      - pkg: find-prereqs
      - file: /etc/mosquitto/mosquitto.conf

/usr/lib/systemd/system/find.service:
  file.managed:
    - watch_in:
      - cmd: daemon-reload
    - template: jinja
    - contents: |
        [Unit]
        Description=The Framework for Internal Navigation and Discovery
        Requires=mosquitto.service
        After=mosquitto.service
        [Service]
        Type=simple
        WorkingDirectory=/opt/go/find
        ExecStart=/bin/bash -c "/opt/go/find/find -mqtt localhost:1883 -mqttadmin '{{ salt['grains.get_or_set_hash']('mqtt:admin_user', 16) }}' -mqttadminpass '{{ salt['grains.get_or_set_hash']('mqtt:admin_pass', 16) }}' -mosquitto $(pgrep mosquitto) -p :80 0.0.0.0:80"
        Restart=always
        [Install]
        WantedBy=multi-user.target

find:
  service.running:
    - require:
      - file: /usr/lib/systemd/system/find.service
      - service: mosquitto
      - cmd: build-find
