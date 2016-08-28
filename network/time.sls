{% set timezone = 'America/New_York' %}

{% if salt['grains.get']('systemd:version') >= 213 %}
timesyncd:
  file.managed:
    - name: /etc/systemd/timesyncd.conf
    - source:
      - salt://network/timesyncd.conf
  cmd.wait:
    - name: timedatectl set-ntp true
    - runas: root
    - watch:
      - file: timesyncd
    - require:
      - pkg: chrony

# This is necessary in order to allow timesyncd to run on virtual machines.
timesyncd-allowvirtual:
  file.managed:
    - name: /etc/systemd/system/systemd-timesyncd.service.d/allowvirtual.conf
    - contents: "[Unit]\nConditionVirtualization="
    - makedirs: True
    - watch_in:
      - cmd: daemon-reload
{% else %}
ntpdate:
  pkg.installed: []
  service.running:
    - enable: True
{% endif %}

timezone:
  cmd.run:
    - name: timedatectl set-timezone '{{ timezone }}'
    - runas: root
    - unless: ls -l '/etc/localtime' | grep '{{ timezone }}'

chrony:
  pkg.installed
