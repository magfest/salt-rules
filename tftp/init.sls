{% set tftp_pkg = salt['grains.filter_by']({
  'Arch': 'tftp-hpa',
  'Debian': 'tftpd-hpa',
  'RedHat': 'tftp-server',
  }, grain='os_family', default='RedHat')
%}

/etc/systemd/system/tftp.service:
  file.managed:
    - source: salt://tftp/tftp.service

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

phone-config-files:
  archive.extracted:
    - source: https://repo.magfe.st/tftp/sipfiles.tar.gz
    - source_hash: https://repo.magfe.st/sipfiles.tar.gz.hash
    - archive_format: tar
    - tar_options: z
    - if_missing: /var/lib/tftpboot/sip.ld

{% if salt['pillar.get']('phone_extensions') %}
polycom-directory:
  file.managed:
    - name: /var/lib/tftpboot/000000000000-directory.xml
    - source: salt://voip-provision/directory.xml
    - template: jinja
    - require: /var/lib/tftpboot
  file.symlink:
    - name: /var/lib/tftpboot/000000000000-directory~.xml
    - target: /var/lib/tftpboot/000000000000-directory.xml
{% endif %}

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
  service.running:
    - enable: True
    - require:
      - pkg: tftp
      - user: tftp
      - file: /var/lib/tftpboot
      - file: /etc/systemd/system/tftp.service
