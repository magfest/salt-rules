foreman-plugins:
  pkg.installed:
   - pkgs:
     - rubygem-foreman_discovery
     - rubygem-foreman_salt
     - rubygem-foreman_templates
     - rubygem-foreman_remote_execution
   - watch_in:
     - service: httpd

foreman-installer:
  pkg.installed

httpd:
  service.running:
    - enable: True
    - require:
      - cmd: install-foreman
      - pkg: foreman-plugins

install-foreman:
  cmd.run:
    - name: |
      foreman-installer \
      {%- for opt in salt['pillars.get]('foreman:installer-args') -%}
      {%- if salt['utils.is_dict'](opt) -%}
      {%- for key, val in dic.items() -%}
      --{{ key }}={{val}} \
      {% endfor -%}
      {%- elif salt['utils.is_bool'](opt) -%}
      --{{ key }}={{ salt['utils.bool_lc'](opt) \
      {% elif salt['utils.is_str'](opt) -%}
      --{{ key}}
      {% endif %}
      {%- endfor -%}
      {%- endfor -%}
    - require:
      - pkg: foreman-installer
      - pkg: foreman-plugins
