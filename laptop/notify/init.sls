notify-deps:
  pkg.installed:
    - name: python

notify-bin:
  file.managed:
    - name: /usr/bin/magnotifier.py:
    - source: salt://laptop/notify/notifier.py
    - mode: '755'

notify-sounds:
  file.recurse:
    - name: /usr/share/sounds/magfest:
    - source: salt://laptop/notify/sounds
    - makedirs: True

notify-service:
  file.managed:
    - name: /usr/lib/systemd/system/magnotifier.service
    - source: salt://laptop/notify/notifier.service

magnotifier:
  service.running:
    - enable: True
    - require:
      - pkg: notify-deps
      - file: notify-bin
      - file: notify-sounds
      - file: notify-service