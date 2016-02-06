{% set repo = salt['grains.filter_by']({
  'CentOS': 'centos.repo',
  'Fedora': 'magfest.repo'
  }, grain='os', default='Fedora') %}

/etc/yum.repos.d/{{ repo }}:
  file.managed:
    - source: salt://repos/yum.repos.d/{{ repo }}
    - user: root
    - group: root
    - makedirs: True
