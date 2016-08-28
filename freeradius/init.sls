freeradius:
  pkg.installed: []

freeradius-utils:
  pkg.installed: []

/etc/raddb/clients.conf:
  file.managed:
    - source: salt://freeradius/clients.conf
      - template: jinja
          
