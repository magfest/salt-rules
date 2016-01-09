include:
  - augeas

openssh-server:
  pkg.installed

openssh-clients:
  pkg.installed

sshd:
  service.running:
    - enabled: True
    - require:
       - pkg: openssh-server
    - watch:
       - augeas: sshd
  augeas.change:
    - context: /files/etc/ssh/sshd_config
    - changes:
      - set PermitEmptyPasswords no
