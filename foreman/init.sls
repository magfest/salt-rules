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

/etc/pki/tls/certs/cert1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: foreman:cert1

/etc/pki/tls/certs/chain1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: foreman:chain1

/etc/pki/tls/certs/fullchain1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: foreman:fullchain1

/etc/pki/tls/private/privkey1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: foreman:privkey1

install-foreman:
  cmd.run:
    - name: |
      foreman-installer \
      {%- for opt in pillar.foreman.installer-args -%}
      {%- if salt['utils.is_dict'](opt) -%}
      {%- for key, val in opt.items() -%}
      --{{ key }}={{val}} \
      {% endfor -%}
      {%- elif salt['utils.is_bool'](opt) -%}
      --{{ key }}={{ salt['utils.bool_lc'](opt) }} \
      {% elif salt['utils.is_str'](opt) -%}
      --{{ key }}
      {% endif %}
      {%- endfor -%}
    - require:
      - pkg: foreman-installer
      - pkg: foreman-plugins
      - file: /etc/pki/tls/*
