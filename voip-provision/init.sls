provision-deps:
  pkg.installed:
    - pkgs:
      - python
      - python-flask
      - python-jinja2
      - python-requests

provision-bin:
  file.managed:
    - name: /usr/bin/provisioner.py
    - source:
      - salt://voip-provision/provisioner.py
    - mode: '775'

provision-dirs:
  file.recurse:
    - name: /etc/voip-provision
    - source: salt://voip-provision/data
    - template: None
    - watch_in:
      - service: provision-service

/srv/tftp:
  file.recurse:
    - source: salt://voip-provision/tftp
    - template: jinja
    - makedirs: True

provision-service:
  file.managed:
    - name: /usr/lib/systemd/system/voip_provision.service
    - source:
      - salt://voip-provision/voip_provision.service
    - watch_in:
      - cmd: daemon-reload

  service.running:
    - name: voip_provision
    - enable: True
    - require:
      - file: provision-service
      - file: provision-dirs
      - pkg: provision-deps
    - watch:
      - file: provision-bin
