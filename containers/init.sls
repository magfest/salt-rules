/etc/systemd/system/systemd-nspawn@.service:
  file.managed:
    - source: salt://containers/systemd-nspawn@.service

arch-install-scripts:
  pkg.installed

pacman:
  pkg.installed

/srv/images:
  file.directory: []

/usr/bin/pacstrap /srv/images/arch base:
  cmd.run:
    - creates: /srv/images/arch
    - require:
      - pkg: arch-install-scripts
      - pkg: pacman
      - file: /srv/images

