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
