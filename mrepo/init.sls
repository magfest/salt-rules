git:
  pkg.installed

/etc/mrepo.conf:
  file.managed:
    - source: salt://mrepo/mrepo.conf
    - require:
      - cmd: mrepo-install

/etc/mrepo.conf.d/fedora.conf:
  file.managed:
    - source: salt://mrepo/fedora.conf
    - require:
      - cmd: mrepo-install

git-mrepo:
  git.latest:
    - name: https://github.com/dagwieers/mrepo.git
    - target: /root/mrepo
    - require:
      - pkg: git

make:
  pkg.installed: []

mrepo-install:
  cmd.run:
    - name: /usr/bin/make install
    - creates: /etc/mrepo.conf
    - cwd: /root/mrepo/
    - require:
      - git: git-mrepo
      - pkg: make

createrepo:
  pkg.installed: []

lftp:
  pkg.installed: []

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://mrepo/nginx.conf
    - require:
      - file: /etc/nginx/

/etc/nginx/:
  file.directory: []

/etc/nginx/ssl/:
  file.directory:
    - require:
      - file: /etc/nginx/  

/etc/nginx/ssl/cert1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: mrepo:cert1
    - require:
      - file: /etc/nginx/ssl/

/etc/nginx/ssl/chain1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: mrepo:chain1
    - require:
      - file: /etc/nginx/ssl/

/etc/nginx/ssl/fullchain1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: mrepo:fullchain1
    - require:
      - file: /etc/nginx/ssl/

/etc/nginx/ssl/privkey1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents_pillar: mrepo:privkey1
    - require:
      - file: /etc/nginx/ssl/

nginx:
  pkg.installed: []
  service.running:
    - enable: True
    - watch:
      - file: /etc/nginx/*
    - require:
      - file: /etc/nginx/*
