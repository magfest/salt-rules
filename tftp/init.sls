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
    - source: https://repo.magfe.st/tftp/sipfiles.tar.gz
    - source_hash: https://repo.magfe.st/sipfiles.tar.gz.hash
    - if_missing: /srv/tftp/tftpboot/sip.ld
    - archive_format: tar
    - tar_options: z
    - require:
      - file: /srv/tftp

/etc/conf.d/tftpd:
  file.managed:
    - source: salt://tftp/conf

{% if salt['pillar.get']('phone_extensions') %}
polycom-directory-a:
  file.managed:
    - name: /srv/tftp/000000000000-directory.xml
    - source: salt://voip-provision/directory.xml
    - template: jinja
    - require:
      - file: /srv/tftp

polycom-directory-b:
  file.symlink:
    - name: /srv/tftp/000000000000-directory~.xml
    - target: /srv/tftp/000000000000-directory.xml
{% endif %}

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
