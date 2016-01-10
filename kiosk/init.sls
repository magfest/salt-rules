/root/kiosk.iso:
  file.managed:
    - source: http://repo.magfest.net/porteus/kiosk.iso
    - source_hash: http://repo.magfest.net/porteus/kiosk.iso.hash

/boot/porteus-initrd.xz:
  file.managed:
    - source: http://repo.magfest.net/porteus/initrd.xz
    - source_hash: http://repo.magfest.net/porteus/initrd.xz.hash

/boot/porteus-vmlinuz:
  file.managed:
    - source: http://repo.magfest.net/porteus/vmlinuz
    - source_hash: http://repo.magfest.net/porteus/vmlinuz.hash

imagekiosk:
  cmd.wait:
    - name: /usr/bin/dd if=/root/kiosk.iso of=/dev/sda4 bs=1M
    - watch:
      - file: /root/kiosk.iso
