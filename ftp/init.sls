/etc/bftpd.conf:
  file.managed:
    - source: salt://ftp/bftpd.conf
    - mode: '600'

bftpd:
  pkg.installed: []
  service.running:
    - name: bftpd.socket
    - require:
      - pkg: bftpd
      - file: /etc/bftpd.conf
