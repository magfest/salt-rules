/etc/systemd/system/challenges.target.wants/chronyd.service:
  file.symlink:
    - target: /usr/lib/systemd/system/chronyd.service

/etc/systemd/system/challenges.target.wants/crond.service:
  file.symlink:
    - target: /usr/lib/systemd/system/crond.service

/etc/systemd/system/challenges.target.wants/NetworkManager.service:
  file.symlink:
    - target: /usr/lib/systemd/system/NetworkManager.service

salt-minion-challenges:
  file.symlink:
    - name: /etc/systemd/system/challenges.target.wants/salt-minion.service
    - target: /usr/lib/systemd/system/salt-minion.service

/etc/systemd/system/challenges.target.wants/salt-minion.service:
  file.symlink:
    - target: /usr/lib/systemd/system/salt-minion.service

/etc/systemd/system/challenges.service:
  file.managed:
    - source: salt://challenges/challenges.service

nopasswdlogin:
  group.present

autologin:
  group.present

challenges:
  service.enabled: []
  user.present:
    - fullname: Challenges
    - shell: /usr/bin/bash
    - empty_password: True
    - home: /home/challenges
    - groups:
      - autologin
      - nopasswdlogin

/usr/bin/startchallenges:
  file.managed:
    - source: salt://challenges/startchallenges
    - mode: 755

/etc/lightdm/challenges.conf:
  file.managed:
    - source: salt://challenges/challenges.conf

lightdm:
  pkg.installed

profile:
  file.managed:
    - name: /home/challenges/.profile
    - source: salt://challenges/profile
    - owner: challenges
    - group: challenges
    - mode: 755

pygame:
  pkg.installed
