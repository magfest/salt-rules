'/etc/yum.repos.d':
  file.recurse:
    - source: salt://repos/yum.repos.d
    - user: root
    - group: root
    - clean: True
