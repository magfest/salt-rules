rsyslog:
  pkg.installed:
    - name: rsyslog
  service.running:
    - enable: True
    - reload: True
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
