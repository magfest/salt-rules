/etc/selinux/config:
  file.managed:
    - source: salt://selinux/config
