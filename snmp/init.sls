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
    - name: net-snmp-create-v3-user -ro -A {{ salt['pillar.get']('snmp:key', "snmppasskey") }} -X {{ salt['pillar.get']('snmp:key', "snmppasskey") }} -a SHA -x AES observium && touch /var/snmp.configured
snmpd:
  service.running:
    - enable: true
    - require:
      - cmd: snmp-cmd
      - pkg: snmp-pkgs
{% endif %}


