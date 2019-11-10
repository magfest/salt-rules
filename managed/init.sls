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
    {% set admins = salt['pillar.get']('admins:default') %}
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
    - runas: root
    - watch:
      - file: /etc/systemd/system/*

# TODO: REMOVE BELOW once everything is migrated
/etc/hostname:
  file.replace:
    - pattern: magfe.st
    - repl: magevent.net

/etc/sysconfig/network:
  file.replace:
    - pattern: magfe.st
    - repl: magevent.net

/etc/salt/minion_id:
  file.replace:
    - pattern: magfe.st
    - repl: magevent.net
    - watch_in:
      - service: salt-minion
