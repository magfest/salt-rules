/etc/systemd/system/systemd-nspawn@.service:
  file.managed:
    - source: salt://containers/systemd-nspawn@.service

arch-install-scripts:
  pkg.installed

pacman:
  pkg.installed

/srv/images:
  file.directory: []

/srv/images/arch:
  file.directory:
    - require:
      - file: /srv/images

/usr/bin/pacstrap -d /srv/images/arch base:
  cmd.run:
    - creates: /srv/images/arch/etc/arch-release
    - require:
      - pkg: arch-install-scripts
      - pkg: pacman
      - file: /srv/images
      - file: /srv/images/arch

