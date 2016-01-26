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
