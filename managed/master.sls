python-pygit2:
  pkg.installed: []

python-tornado:
  pkg.installed: []

salt-master:
  service.running:
    - enable: True
    - require:
      - pkg: python-pygit2

salt-api:
  service.running:
    - enable: True
    - require:
      - pkg: python-tornado

salt-master-config:
  file.managed:
    - name: /etc/salt/master
    - source:
      - salt://managed/master.yaml
    - template: jinja
    - watch_in:
      - service: salt-master

/srv/reactor/update_fileserver.sls:
  file.managed:
    - makedirs: True
    - contents: |
      update_fileserver:
        runner.fileserver.update
