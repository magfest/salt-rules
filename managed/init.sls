salt-minion:
  service.running:
    - enable: True

salt-minion-config:
  file.managed:
    - name: /etc/salt/minion
    - source:
      - salt://managed/minion.yaml
    - template: jinja
    - watch_in:
      - service: salt-minion

salt-group:
  group.present:
    - name: salt
    - system: True
    {% set admins = salt['utils.merged_pillars']('admins:default', 'admins:' + grains['host']) %}
    {% if admins %}
    - members:
      {% for admin in admins.keys() %}
      - {{admin}}
      {% endfor %}
    - require:
      {% for admin in admins.keys() %}
      - user: {{admin}}
      {% endfor %}
    {% endif %}


daemon-reload:
  cmd.wait:
    - name: systemctl daemon-reload
    - user: root
    - group: root
    - watch:
      - file: /etc/systemd/system/*
