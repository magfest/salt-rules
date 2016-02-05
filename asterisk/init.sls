asterisk:
  pkg.installed: []

  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: asterisk
      - file: /etc/asterisk

python:
  pkg.installed

python-flask:
  pkg.installed:
    - require:
      - pkg: python-flask

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
