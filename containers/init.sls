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

/etc/pacman.conf:
  file.managed:
    - source: salt://containers/pacman.conf

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
      - pkg: gnupg
      - pkg: pacman
      - service: rngd

/usr/bin/pacman-key --populate:
  cmd.wait:
    - require:
      - cmd: /usr/bin/pacman-key --init
    - watch:
      - cmd: /usr/bin/pacman-key --init

arch-installroot:
  cmd.run:
    - name: /usr/bin/pacstrap -d /srv/images/arch base salt-zmq
    - creates: /srv/images/arch/etc/arch-release
    - require:
      - pkg: arch-install-scripts
      - pkg: pacman
      - file: /srv/images
      - file: /srv/images/arch
      - file: /etc/pacman.conf
      - cmd: /usr/bin/pacman-key --init
      - cmd: /usr/bin/pacman-key --populate

fedora-installroot:
  cmd.run:
    - name: /usr/bin/dnf --installroot=/srv/images/fedora -y groupinstall core
    - creates: /srv/images/fedora/etc/fedora-release
    - require:
      - file: /srv/images

fedora-salt:
  cmd.run:
    - name: /usr/bin/dnf --installroot=/srv/images/fedora -y install salt-minion
    - creates: /srv/images/fedora/usr/bin/salt-call
    - require:
      - cmd: fedora-installroot

/usr/bin/create-centos-image:
  file.managed:
    - source: salt://containers/create-centos-image
    - mode: 755

centos-image:
  cmd.run:
    - name: /usr/bin/create-centos-image centos
    - source: salt://containers/create-centos-image
    - creates: /srv/images/centos/usr/bin/salt-minion
    - require:
      - file: /usr/bin/create-centos-image

/srv/images/arch/etc/salt/minion:
  file.managed:
    - source: salt://managed/minion.yaml
    - require:
      - cmd: arch-installroot

/srv/images/fedora/etc/salt/minion:
  file.managed:
    - source: salt://managed/minion.yaml
    - require:
      - cmd: fedora-salt

/srv/images/centos/etc/salt/minion:
  file.managed:
    - source: salt://managed/minion.yaml
    - require:
      - cmd: centos-image

/srv/images/arch/etc/securetty:
  file.append:
    - text:
      - "pts/0"

/srv/images/arch/etc/shadow:
  file.replace:
    - pattern: "^root::.*$"
    - repl: "root:$6$oisdfoiaj$rffY1PXLJ5DLMOV/nmA8elQRRNbq8hgK7K/WZsXc3SOvmFZd6qRYXRH9IttsQ7x3yXbShSbJcn9h0j7/T7uQC1:14871::::::"

/srv/images/fedora/etc/shadow:
  file.replace:
    - pattern: "^root:.:.*$"
    - repl: "root:$6$oisdfoiaj$rffY1PXLJ5DLMOV/nmA8elQRRNbq8hgK7K/WZsXc3SOvmFZd6qRYXRH9IttsQ7x3yXbShSbJcn9h0j7/T7uQC1:16805:0:99999:7:::"
