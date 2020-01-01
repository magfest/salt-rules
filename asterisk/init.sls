asterisk:
  pkg.installed:
    - pkgs:
      - asterisk
      - asterisk-sip
      - asterisk-sounds-core-en-wav
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: asterisk

reloader-deps:
  pkg.installed:
    - pkgs:
      - python2
      - python2-flask

reloader-service:
  file.managed:
    - name: /usr/lib/systemd/system/asterisk_reloader.service
    - source:
      - salt://asterisk/reloader.service
    - watch_in:
      - cmd: asterisk-daemon-reload

  service.running:
    - name: asterisk_reloader
    - enable: True
    - require:
      - file: /usr/bin
      - file: reloader-service
      - pkg: reloader-deps

asterisk-daemon-reload:
  cmd.wait:
    - name: systemctl daemon-reload
    - runas: root

/usr/share/asterisk/sounds/magfest:
  file.recurse:
    - source: salt://asterisk/sounds
    - makedirs: True

{% for conf_file in ['skinny', 'sip', 'extensions', 'rtp', 'confbridge', 'queues', 'iax'] %}
/etc/asterisk/{{ conf_file }}.conf:
  file.managed:
    - source: salt://asterisk/conf/{{ conf_file }}.conf
    - template: jinja
    - makedirs: True
    - watch_in:
      - service: asterisk
{% endfor %}

/usr/bin:
  file.recurse:
    - source: salt://asterisk/scripts
    - file_mode: '755'
