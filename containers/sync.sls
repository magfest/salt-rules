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

{% for server, key in salt['mine.get']('roles:containerhost', 'sshkey', expr_form='pillar').items() %}
{{ server }}:
  ssh_known_hosts.present:
    - key: {{ key }}
    - user: root
    - enc: ssh-rsa
{% endfor %}
