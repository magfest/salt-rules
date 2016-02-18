cups:
  pkg.installed: []
  group.present:
    - name: printadmin
    - system: True
    {% if pillar.admins %}
    - members:
      {% for admin in pillar.admins.keys() %}
      - {{admin}}
      {% endfor %}
    {% endif %}
    - require:
      - pkg: cups
      {% for admin in pillar.admins.keys() %}
      - user: {{admin}}
      {% endfor %}
  service.running:
    - enable: True
    - require:
      - pkg: cups

cups-web:
  service.running:
    - name: cups-browsed
    - enable: True
    - require:
      - pkg: cups

ghostscript:
  pkg.installed: []
