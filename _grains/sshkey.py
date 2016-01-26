#!/usr/bin/env python
def sshkey():
  grains = {}
  with open("/etc/ssh/ssh_host_rsa_key.pub", "r") as sshkeyFile:
    grains['sshkey'] = sshkeyFile.read().split(" ")[1]
  return grains
