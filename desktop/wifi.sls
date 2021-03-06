{% for ssid, options in salt['pillar.get']('wifi:networks', {}).items() %}
/etc/sysconfig/network-scripts/ifcfg-{{ ssid.replace(' ','_') }}:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://desktop/ifcfg-base.jinja
    - template: jinja
    - context:
      ssid: {{ ssid }}
      options: {{ options }}
      uuid: {{ salt['utils.consistent_uuid']('wifi_net:' + ssid ) }}
{% if 'key_mgmt' in options %}
/etc/sysconfig/network-scripts/keys-{{ ssid.replace(' ', '_') }}:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    - source: salt://desktop/keys-base.jinja
    - template: jinja
    - context:
      key_mgmt: {{ options.get('key_mgmt') }}
      key: {{ options.get('key', '') }}
      options: {{ options }}
{% endif %}
{% if 'cert' in options %}
/etc/ssl/wifi/{{ ssid.lower().replace(' ', '_') }}.crt:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - contents_pillar: wifi:networks:{{ ssid }}:cert
    - makedirs: True
{% endif %}
{% endfor %}
