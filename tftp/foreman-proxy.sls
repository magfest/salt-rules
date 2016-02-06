foreman-release:
  pkg.installed:
    - sources:
      - foreman-release: salt://foreman/foreman-release.rpm

/etc/foreman-proxy/settings.yml:
  file.managed:
    - source: salt://tftp/settings.yml
    - watch_in:
      - service: foreman-proxy

foreman-proxy:
  pkg.installed:
    - require:
      - pkg: foreman-release
  service.running:
    - enabled: True
    - require:
      - file: /etc/foreman-proxy/settings.yml
      - pkg: foreman-proxy
