asterisk:
  pkg.installed: []

  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: asterisk
      - file: /etc/asterisk

reloader-deps:
  pkg.installed:
    - pkgs:
      - python
      - python-flask

reloader-service:
  file.managed:
    - name: /usr/lib/systemd/system/asterisk_reloader.service
    - source:
      - salt://asterisk/reloader.service
    - watch_in:
      - cmd: daemon-reload

  service.running:
    - name: asterisk_reloader
    - enable: True
    - require:
      - file: /usr/bin
      - file: reloader-service
      - pkg: reloader-deps

/etc/asterisk:
  file.recurse:
    - source: salt://asterisk/conf
    - template: jinja
    - watch_in:
      - service: asterisk

/usr/bin:
  file.recurse:
    - source: salt://asterisk/scripts
    - file_mode: '755'
