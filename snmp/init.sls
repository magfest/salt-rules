{% if salt['grains.get']('os') == "CentOS" %}
snmp-pkgs:
  pkg.installed:
    - pkgs:
      - net-snmp
      - net-snmp-utils
      - net-snmp-libs
snmp-cmd:
  cmd.run:
    - creates:
      - /var/snmp.configured
    - name: net-snmp-create-v3-user -ro -A {{ salt['pillar.get']('snmp:auth-key', "snmphashkey") }} -X {{ salt['pillar.get']('snmp:hash-key', "snmppasskey") }} -a SHA -x AES {{ salt['pillar.get']('snmp:username', "librenms") }} && touch /var/snmp.configured
snmpd:
  service.running:
    - enable: true
    - require:
      - cmd: snmp-cmd
      - pkg: snmp-pkgs
{% endif %}


