/etc/bftpd.conf:
  file.managed:
    - source: salt://ftp/bftpd.conf
    - mode: '600'

/srv/ftp:
  file.symlink:
    - target: /var/lib/tftpboot

bftpd:
  pkg.installed: []
  service.running:
    - name: bftpd.socket
    - require:
      - pkg: bftpd
      - file: /etc/bftpd.conf
      - file: /srv/ftp
