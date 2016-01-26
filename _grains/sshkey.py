#!/usr/bin/env python
def sshkey():
  grains = {}
  with open("/etc/ssh/ssh_host_ecdsa_key.pub", "r") as sshkeyFile:
    grains['sshkey'] = sshkeyFile.read()
  return grains
