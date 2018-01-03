{% set admins = salt['utils.merged_pillars']('admins:default', 'admins:' + grains['host']) %}
cups:
  pkg.installed: []
  group.present:
    - name: printadmin
    - system: True
    {% if admins %}
    - members:
      {% for admin in admins.keys() %}
      - {{admin}}
      {% endfor %}
    {% endif %}
    - require:
      - pkg: cups
      {% for admin in admins.keys() %}
      - user: {{admin}}
      {% endfor %}
  service.running:
    - enable: True
    - require:
      - pkg: cups
    - watch:
      - file: /etc/cups/cupsd.conf

cups-web:
  service.running:
    - name: cups-browsed
    - enable: True
    - require:
      - pkg: cups

/etc/cups/cupsd.conf:
  file.managed:
    - source: salt://cups/cupsd.conf
    - require:
      - pkg: cups

ghostscript:
  pkg.installed: []
