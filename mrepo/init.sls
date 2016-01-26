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

mrepo-install:
  cmd.run:
    - name: /usr/bin/make install
    - creates: /etc/mrepo.conf
    - cwd: /root/mrepo/
    - require:
      - git: git-mrepo

createrepo:
  pkg.installed: []

lftp:
  pkg.installed: []

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://mrepo/nginx.conf

/etc/nginx/ssl/:
  file.directory: []  

/etc/nginx/ssl/cert1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents: "{{ salt['pillar.get']('mrepo:cert1')|indent(4) }}"

/etc/nginx/ssl/chain1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents: "{{ salt['pillar.get']('mrepo:chain1')|indent(4) }}"

/etc/nginx/ssl/fullchain1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents: "{{ salt['pillar.get']('mrepo:fullchain1')|indent(4) }}"

/etc/nginx/ssl/privkey1.pem:
  file.managed:
    - mode: 0640
    - user: root
    - group: root
    - contents: "{{ salt['pillar.get']('mrepo:privkey1')|indent(4) }}"

nginx:
  pkg.installed: []
  service.running:
    - enable: True
    - watch:
      - file: /etc/nginx/*
    - require:
      - file: /etc/nginx/*
