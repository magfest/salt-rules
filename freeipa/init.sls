freeipa-server:
  pkg.installed

/etc/pki/tls/certs/cert1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: freeipa:cert1

/etc/pki/tls/certs/chain1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: freeipa:chain1

/etc/pki/tls/certs/fullchain1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: freeipa:fullchain1

/etc/pki/tls/private/privkey1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: freeipa:privkey1
