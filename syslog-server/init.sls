include:
  - syslog

extend:
  rsyslog:
    pkg.installed:
      - name: rsyslog
    service.running:
      - enable: True
      - restart: True
      - require:
        - pkg: rsyslog
        - file: /etc/rsyslog.conf

/etc/rsyslog.conf:
  file.managed:
    - source: salt://syslog-server/rsyslog.conf
    - makedirs: True
    - require:
      - pkg: rsyslog
    - watch_in:
      - service: rsyslog

/etc/cron.daily/compress_syslogs.sh:
  file.managed:
    - source: salt://syslog-server/compress_syslogs.sh
    - makedirs: True
    - mode: '0755'
    - user: root
    - group: root
    - require:
      - pkg: rsyslog
