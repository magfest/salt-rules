certbot:
  pkg.installed: []

dns-lexicon:
  pip.installed: []

/opt/dehydrated:
  file.directory: []

https://github.com/lukas2511/dehydrated.git:
  git.latest:
    - target: /opt/dehydrated
    - require:
      - file: /opt/dehydrated

/usr/bin/dehydrated.default.sh:
  file.managed:
    - source: salt://ssl/dehydrated.default.sh
    - mode: 755
    - user: root
    - group: root

/etc/dehydrated/domains.txt:
  file.managed:
    - source: salt://ssl/domains.txt
    - template: jinja
    - makedirs: True

# TODO: Get rid of CA when everything is figured out
ssl-{{ grains['id'] }}:
  cmd.run:
    - name: /opt/dehydrated/dehydrated --challenge dns-01 --cron --hook=/usr/bin/dehydrated.default.sh
    - env:
      - CA: https://acme-staging.api.letsencrypt.org/directory
      - LEXICON_{{ salt['grains.get']('letsencrypt:provider')|upper }}_TOKEN: {{ salt['grains.get']('letsencrypt:token') }}
      - PROVIDER: {{ salt['grains.get']('letsencrypt:provider') }}
      - BASEDIR: /etc/dehydrated
    - require:
      - git: https://github.com/lukas2511/dehydrated.git
      - pkg: certbot
      - pip: dns-lexicon
      - file: /usr/bin/dehydrated.default.sh
      - file: /etc/dehydrated/domains.txt
