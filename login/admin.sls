{% set admins = salt['pillar.get']('admins:default') %}
{% for admin, properties in admins.items() %}
{{ admin }}:
  user.present:
    - remove_groups: False
    {% for key, value in properties.items() %}
    - {{key}}: {{value}}
    {% endfor %}
  {% if pillar.ssh_keys and admin in salt['pillar.get']('ssh_keys', {}) %}
  ssh_auth.present:
    - user: {{ admin }}
    - name: {{ salt['pillar.get']('ssh_keys:' + admin) }}
  {% endif %}
{% endfor %}

sudo:
  group.present:
    - name: wheel
    {% if admins %}
    - members:
      {% for admin in admins.keys() %}
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
{% if grains['host'] in pillar.rootpw_overrides %}
    - password: {{ pillar.rootpw_overrides[grains['host']] }}
{% else %}
    - password: {{ pillar.rootpw }}
{% endif %}
{% if pillar.root_keys and grains['host'] in pillar.root_keys %}
  ssh_auth.present:
    - user: root
    - name: {{ salt['pillar.get']('root_keys:' + grains['host']) }}
{% endif %}
{% endif %}
