/etc/hosts:
  file.managed:
    - source: salt://hosts/hosts.jinja
    - template: jinja
