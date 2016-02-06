{% set tftp_pkg = salt['grains.filter_by']({
  'Arch': 'tftp-hpa',
  'Debian': 'tftpd-hpa',
  'RedHat': 'tftp-server',
  }, grain='os_family', default='RedHat')
%}

/srv/tftp:
  file.directory:
    - user: root
    - group: tftp
    - dir_mode: 777
    - file_mode: 664
    - recurse:
      - group
    - makedirs: True
    - require:
      - group: tftp
      - user: tftp
  archive.extracted:
    - source: https://repo.magfe.st/tftp/tftp.tar.gz
    - hash: https://repo.magfe.st/tftp/tftp.tar.gz.hash

/etc/conf.d/tftpd:
  file.managed:
    - source: salt://tftp/conf

tftp:
  pkg.installed:
    - name: {{ tftp_pkg }}
  group.present: []
  user.present:
    - shell: /bin/nologin
    - home: /srv/tftp
    - system: True
    - groups:
      - tftp

tftpd:
  service.running:
    - enable: True
    - require:
      - pkg: tftp
      - user: tftp
      - file: /srv/tftp
    - watch:
      - file: /etc/conf.d/tftpd
