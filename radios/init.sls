radios-reqs:
  pkg.installed:
    - pkgs:
      - python
      - python-jinja2
      - python-flask

/opt/radios:
  file.directory:
    - makedirs: True
  git.latest:
    - source: https://github.com/magfest/radio-manager-2.git
    - require:
      - file: /opt/radios

/usr/lib/systemd/system/radios.service:
  file.managed:
    - require:
      - git: /opt/radios
    - source: /opt/radios/radios.service

/opt/radios/config.json:
  file.managed:
    - require:
      - git: /opt/radios
    - contents: {{ salt['pillar.get']('radios:config')|json }}

radios.service:
  service.running:
    - enable: True
    - require:
      - file: /usr/lib/systemd/system/radios.service
      - file: /opt/radios/config.json
      - pkg: radios-reqs
