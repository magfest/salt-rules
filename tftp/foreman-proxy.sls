foreman-release:
  pkg.installed:
    - sources:
      - foreman-release: salt://tftp/foreman-release.rpm

/etc/foreman-proxy/settings.yml:
  file.managed:
    - source: salt://tftp/settings.yml
    - watch_in:
      - service: foreman-proxy
    - makedirs: True

foreman-proxy:
  pkg.installed:
    - require:
      - pkg: foreman-release
  service.running:
    - enable: True
    - require:
      - file: /etc/foreman-proxy/settings.yml
      - pkg: foreman-proxy
