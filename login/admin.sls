{% if pillar.admins %}
{% for admin, properties in pillar.admins.items() %}
{{ admin }}present:
  user.present:
    - name: {{ admin }}
    - remove_groups: False
{{ admin }}passwd:
  user.present:
    - name: {{ admin }}
    - require:
      - user: {{ admin }}present
    {% for key, value in properties.items() %}
    - {{key}}: {{value}}
    {% endfor %}
  ssh_auth.present:
    - user: {{ admin }}
    - source: salt://login/keys/{{ admin }}
{% endfor %}
{% endif %}

sudo:
  group.present:
    - name: wheel
    {% if pillar.admins %}
    - members:
      {% for admin in pillar.admins.keys() %}
      - {{admin}}
      {% endfor %}
    {% endif %}
  pkg.installed:
    - name: sudo
  file.managed:
    - name: /etc/sudoers
    - source: salt://login/sudoers

{% if pillar.rootpw %}
root:
  user.present:
    - remove_groups: False
    - password: {{ pillar.rootpw }}
{% endif %}

