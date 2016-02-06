{% set tftp_pkg = salt['grains.filter_by']({
  'Arch': 'tftp-hpa',
  'Debian': 'tftpd-hpa',
  'RedHat': 'tftp-server',
  }, grain='os_family', default='RedHat')
%}

/var/lib/tftpboot:
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
    - source_hash: https://repo.magfe.st/tftp/tftp.tar.gz.hash
    - archive_format: tar
    - tar_options: z

/etc/conf.d/tftpd:
  file.managed:
    - source: salt://tftp/conf
    - makedirs: True

tftp:
  pkg.installed:
    - name: {{ tftp_pkg }}
  group.present: []
  user.present:
    - shell: /bin/nologin
    - home: /var/lib/tftpboot
    - system: True
    - groups:
      - tftp

tftp:
  service.running:
    - enable: True
    - require:
      - pkg: tftp
      - user: tftp
      - file: /var/lib/tftpboot
    - watch:
      - file: /etc/conf.d/tftpd
