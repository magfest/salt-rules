lp:
  group.present:
    {% if pillar.admins %}
    - members:
      {% for admin in pillar.admins['default'].keys() %}
      - {{admin}}
      {% endfor %}
    {% endif %}

