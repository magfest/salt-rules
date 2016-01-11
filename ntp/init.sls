ntp:
  pkg.installed:
    - name: ntp
  service.running:
    - name: ntpd
    - require:
      - pkg: ntp
      - file: /etc/ntp.conf
      - file: /var/lib/ntp

/etc/ntp.conf:
  file.managed:
    - source: salt://ntp/ntp.conf
    - watch_in:
      - service: ntp

/var/lib/ntp:
  file.directory:
    - makedirs: True
