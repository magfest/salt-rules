rsyslog:
  pkg.installed:
    - name: rsyslog
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: rsyslog
      - file: /etc/rsyslog.d/remote-server.conf

/etc/rsyslog.d/remote-server.conf:
  file.managed:
    - source: salt://syslog/remote-server.conf
    - makedirs: True
    - require:
      - pkg: rsyslog
    - watch_in:
      - service: rsyslog
