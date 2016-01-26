lsyncd:
  pkg.installed: []

/root/.ssh:
  file.directory:
    - mode: 700

/root/.ssh/id_rsa:
  file.managed:
    - source: salt://containers/keys/root
    - require:
      - file: /root/.ssh
    - mode: 600
    - owner: root
    - group: root

/root/.ssh/authorized_keys:
  file.managed:
    - source: salt://containers/keys/root.pub
    - require:
      - file: /root/.ssh
    - mode: 600
    - owner: root
    - group: root

/etc/sysctl.d/10-inotify.conf:
  file.managed:
    - source: salt://containers/10-inotify.conf

sysctl -p --system:
  cmd.wait:
    - watch:
      - file: /etc/sysctl.d/10-inotify.conf

{% for server, key in salt['mine.get']('*', 'sshkeys').items() %}
{% if server != grains['nodename'] %}
{{ server }}-known_hosts:
  file.append:
    - name: /root/.ssh/known_hosts
    - text:
      - "{{ server }} {{ key }}"
{% endif %}
{% endfor %}

/etc/containersync.conf:
  file.managed:
    - source: salt://containers/sync/containersync.conf

/usr/bin/containersync:
  file.managed:
    - source: salt://containers/sync/containersync
    - mode: 755

/etc/systemd/system/containersync.service:
  file.managed:
    - source: salt://containers/sync/containersync.service

/usr/lib/containersync:
  file.directory: []

/usr/lib/containersync/lsyncd.conf.jinja:
  file.managed:
    - source: salt://containers/sync/lsyncd.conf.jinja
    - require:
      - file: /usr/lib/containersync

/var/lib/containersync:
  file.directory: []

containersync:
  service.enabled:
    - require:
      - file: /etc/containersync.conf
      - file: /usr/bin/containersync
      - file: /etc/systemd/system/containersync.service
      - file: /usr/lib/containersync
      - file: /usr/lib/containersync/lsyncd.conf.jinja
      - file: /var/lib/containersync
