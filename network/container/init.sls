network:
  service.disabled

{% if salt['grains.get']('os') == 'CentOS' %}
systemd-networkd:
  pkg.installed
{% endif %}

systemd-networkd-service:
  service.enabled:
    - name: systemd-networkd
{% if salt['grains.get']('os') == "CentOS" %}
    - require:
      - pkg: systemd-networkd
{% endif %}

/etc/systemd/network:
  file.directory: []

/etc/systemd/network/80-container-host0.network:
  file.managed:
    - source: salt://network/container/80-container-host0.network
    - template: jinja
    - require:
      - file: /etc/systemd/network
