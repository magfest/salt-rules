salt://desktop/wallpaper/makelabsbg:
  cmd.script:
    - args: 1366 768 /usr/share/backgrounds/maglabs.png 100
    - require:
      - pkg: ImageMagick
      - file: /usr/share/magfest/images/labs_bg
    - watch_in:
      - cmd: update-pcmanfm

update-pcmanfm:
  cmd.wait:
    - name: su magfest -c 'pcmanfm --set-wallpaper=/usr/share/background/maglabs.png --wallpaper-mode=center'
    - env:
      - DISPLAY: ":0.0"

ImageMagick:
  pkg.installed: []

/usr/share/magfest/images/labs_bg:
  file.recurse:
    - source: salt://desktop/wallpaper/labs_bg

