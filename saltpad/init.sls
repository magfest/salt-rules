saltpad-package:
  archive.extracted:
    - name: /tmp/saltpad/
    - source: https://github.com/Lothiraldan/saltpad/releases/download/v0.3.1/dist.zip
    - source_hash: sha1=4c25b16234ac900085358574bdc1041e65e7d4e6
    - if_missing: /srv/saltpad/
    - archive_format: zip

move-saltpad:
  file.copy:
    - name: /srv/saltpad
    - source: /tmp/saltpad/dist
    - makedirs: True
    - require:
      - archive: saltpad-package

/srv/saltpad/static/settings.json:
  file.managed:
    - source: salt://saltpad/settings.json
    - makedirs: True
    - require:
      - file: move-saltpad

nginx:
  pkg.installed: []
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://saltpad/nginx.conf
    - makedirs: True
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
