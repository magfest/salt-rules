include:
  - augeas
{% if salt['grains.get']('os') == "CentOS" %}
openssh:
  pkg.installed:
    - pkgs:
      - openssh-clients
      - openssh-server
{% else %}
openssh:
  pkg.installed
{% endif %}

sshd:
  service.running:
    - enable: True
    - require:
       - pkg: openssh
    - watch:
       - augeas: sshd
  augeas.change:
    - context: /files/etc/ssh/sshd_config
    - changes:
      - set PermitEmptyPasswords no
      - set PasswordAuthentication no
      - set Match[1]/Condition/User "hacluster"
      - set Match[1]/Settings/PasswordAuthentication "yes"
