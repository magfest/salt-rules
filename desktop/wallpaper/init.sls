salt://desktop/wallpaper/makelabsbg:
  cmd.script:
    - args: 1366 768 /usr/share/backgrounds/maglabs.png 100
    - creates: /usr/share/backgrounds/maglabs.png
    - require:
      - pkg: ImageMagick
      - file: /usr/share/magfest/images/labs_bg

ImageMagick:
  pkg.installed: []

/usr/share/magfest/images/labs_bg:
  file.recurse:
    - source: salt://desktop/wallpaper/labs_bg

