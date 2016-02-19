asterisk-skinny:
  pkg.installed: []

asterisk:
  pkg.installed: []

asterisk-sip:
  pkg.installed: []

asterisk:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: asterisk
      - pkg: asterisk-skinny
      - pkg: asterisk-sip

reloader-deps:
  pkg.installed:
    - pkgs:
      - python
      - python-flask

reloader-service:
  file.managed:
    - name: /usr/lib/systemd/system/asterisk_reloader.service
    - source:
      - salt://asterisk/reloader.service
    - watch_in:
      - cmd: daemon-reload

  service.running:
    - name: asterisk_reloader
    - enable: True
    - require:
      - file: /usr/bin
      - file: reloader-service
      - pkg: reloader-deps

/var/lib/asterisk/sounds/en/magfest:
  file.recurse:
    - source: salt://asterisk/sounds
    - makedirs: True

{% for conf_file in ['skinny', 'sip', 'extensions'] %}
/etc/asterisk/{{ conf_file }}.conf:
  file.managed:
    - source: salt://asterisk/conf/{{ conf_file }}.conf
    - template: jinja
    - watch_in:
      - service: asterisk
{% endfor %}

/usr/bin:
  file.recurse:
    - source: salt://asterisk/scripts
    - file_mode: '755'
