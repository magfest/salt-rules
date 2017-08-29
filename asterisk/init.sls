asterisk:
  pkg.installed:
    - sources:
      - pjproject: https://dl.dropboxusercontent.com/s/69jy4v329jgbc0d/pjproject-2.5.5-2-x86_64.pkg.tar.xz
      - asterisk: https://dl.dropboxusercontent.com/s/1dbqlhwmg8bvl5s/asterisk-13.10.0-2-x86_64.pkg.tar.xz
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: asterisk

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

/var/lib/asterisk/sounds/en/magfest:
  file.recurse:
    - source: salt://asterisk/sounds
    - makedirs: True

{% for conf_file in ['skinny', 'sip', 'extensions', 'rtp', 'confbridge'] %}
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
