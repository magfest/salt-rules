#!/usr/bin/env python2
import socket
import sys
import os
import threading
import random
import time

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

server_address = ('0.0.0.0', 1337)
sock.bind(server_address)

def ding():
  time.sleep(random.gammavariate(.75,2))
  os.system("aplay /usr/share/sounds/magfest/ding.wav")
  return

def rebroadcast(val):
  s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  try:
    s.bind(('',0))
    s.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    s.sendto(val, ('<broadcast>', 1337))
  finally:
    s.close()

while True:
  data, address = sock.recvfrom(256)
  if data.startswith(b'broadcast'):
    rebroadcast(data[9:])
  elif data.startswith(b'ding'):
    threading.Thread(target=ding).start()
