tftp-hpa:
  pkg.installed

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
    - source: https://dl.dropboxusercontent.com/u/22486038/tftp.tar.gz
    - source_hash: sha256=6b38d5c59102e9de299c174690ef4d2f3a2ca69066a56362d9607cb0e6f2353b
    - if_missing: /srv/tftp/tftpboot/sip.ld
    - archive_format: tar
    - tar_options: z
    - require:
      - file: /srv/tftp

/etc/conf.d/tftpd:
  file.managed:
    - source: salt://tftp/conf

tftp:
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
      - pkg: tftp-hpa
      - user: tftp
      - file: /srv/tftp
    - watch:
      - file: /etc/conf.d/tftpd
