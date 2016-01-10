{% for gpu in grains['gpus'] %} 
{% if gpu['vendor'] == 'nvidia' %} 
xorg-x11-drv-nouveau: 
  pkg.installed
{% endif %}
{% if gpu['vendor'] == 'intel' %} 
xorg-x11-drv-intel: 
  pkg.installed
{% endif %}
{% if gpu['vendor'] == 'ati' %} 
xorg-x11-drv-ati: 
  pkg.installed
{% endif %}  
{% if gpu['vendor'] == 'vmware' %} 
xorg-x11-drv-vmware: 
  pkg.installed
{% endif %}
{% endfor %} 
