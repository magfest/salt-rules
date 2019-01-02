radios-reqs:
  pkg.installed:
    - pkgs:
      - git
      - python
      - python-jinja2
      - python-flask
      - python-gunicorn

/opt/radios:
  file.directory:
    - makedirs: True
  git.latest:
    - name: https://github.com/magfest/radio-manager-2.git
    - target: /opt/radios
    - require:
      - file: /opt/radios
      - pkg: radios-reqs

/usr/lib/systemd/system/radios.service:
  file.managed:
    - require:
      - git: /opt/radios
    - source: /opt/radios/radios.service

/opt/radios/config.json:
  file.managed:
    - require:
      - git: /opt/radios
    - source: salt://radios/config.json
    - template: jinja

radios.service:
  service.running:
    - enable: True
    - require:
      - file: /usr/lib/systemd/system/radios.service
      - file: /opt/radios/config.json
      - pkg: radios-reqs
