
% set admins = salt['utils.merged_pillars']('admins:default', 'admins:' + grains['host']) %}
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

cups-web:
  service.running:
    - name: cups-browsed
    - enable: True
    - require:
      - pkg: cups

ghostscript:
  pkg.installed: []
