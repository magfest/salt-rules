foreman-plugins:
  pkg.installed:
   - pkgs:
     - tfm-rubygem-foreman_discovery
     - tfm-rubygem-foreman_salt
     - tfm-rubygem-foreman_templates
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
        {% for opt in salt['pillar.get']('foreman:installer-args') -%}
        {%- if salt['utils.is_dict'](opt) -%}
        {%- for key, val in opt.items() -%}
        --{{ key }}={{val}} \
        {% endfor -%}
        {% elif salt['utils.is_str'](opt) -%}
        --{{ opt }} \
        {% endif %}
        {%- endfor %}
    - require:
      - pkg: foreman-installer
      - pkg: foreman-plugins
      - file: /etc/pki/tls/*

/etc/sudoers:
  file.append:
    - text:
      - Cmnd_Alias SALT = /usr/bin/salt, /usr/bin/salt-key
      - foreman-proxy ALL = NOPASSWD: SALT
      - Defaults:foreman-proxy !requiretty

/etc/salt/master:
  file.managed:
    - source: salt://foreman/master

/etc/salt/autosign.conf:
  file.managed:
    - mode: 664
    - group: foreman-proxy
