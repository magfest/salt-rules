/usr/lib/systemd/system/highstate.timer:
  file.managed:
    - source:
      - salt://managed/highstate.timer
    - require_in:
      - service: highstate.timer

/usr/lib/systemd/system/highstate.service:
  file.managed:
    - source:
      - salt://managed/highstate.service

highstate.timer:
  service.running:
    - enable: True

