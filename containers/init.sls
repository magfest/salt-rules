/etc/systemd/system/systemd-nspawn@.service:
  file.managed:
    - source: salt://containers/systemd-nspawn@.service

rng-tools:
  pkg.installed: []

rngd:
  service.running:
    - enable: True
    - require:
      - pkg: rng-tools
      - file: /etc/sysconfig/rngd
      - file: /etc/systemd/system/rngd.service

/etc/sysconfig/rngd:
  file.managed:
    - source: salt://containers/rngd

/etc/systemd/system/rngd.service:
  file.managed:
    - source: salt://containers/rngd.service

arch-install-scripts:
  pkg.installed

pacman:
  pkg.installed

gnupg:
  pkg.installed

/srv/images:
  file.directory: []

/srv/images/arch:
  file.directory:
    - require:
      - file: /srv/images

/usr/bin/pacman-key --init:
  cmd.run:
    - creates: /etc/pacman.d/gnupg/trustdb.gpg
    - require:
      - pkg: gpg
      - pkg: pacman
      - service: rngd

/usr/bin/pacstrap -d /srv/images/arch base:
  cmd.run:
    - creates: /srv/images/arch/etc/arch-release
    - require:
      - pkg: arch-install-scripts
      - pkg: pacman
      - file: /srv/images
      - file: /srv/images/arch
      - cmd: /usr/bin/pacman-key --init
