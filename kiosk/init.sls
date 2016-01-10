/root/kiosk.iso:
  file.managed:
    - source: https://repo.magfest.net/porteus/kiosk.iso
    - source_hash: https://repo.magfest.net/porteus.kiosk.iso.hash

imagekiosk:
  exec.wait:
    - name: /usr/bin/dd if=/root/kiosk.iso of=/dev/sda4 bs=1M
    - watch:
      - file: /root/kiosk.iso

vmlinuz:
  file.copy:
    - name: /boot/porteus-vmlinuz
    - source: /porteus/boot/vmlinuz
    - force: True
