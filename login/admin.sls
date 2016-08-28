{% if pillar.admins %}
{% set admins = salt['pillar.get']('admins:default', {}) %}
{% set local_admins = salt['pillar.get']('admins:' + grains['host'], {}) %}
{% set _ = salt['utils.merge'](admins, local_admins) %}
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
{% else %}
{% set admins = {} %}
{% endif %}

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
{% if salt['grains.get']('host', None) in pillar.rootpw_overrides %}
    - password: {{ pillar.rootpw_overrides[salt['grains.get']('host', None)] }}
{% else %}
    - password: {{ pillar.rootpw }}
{% endif %}
{% endif %}
