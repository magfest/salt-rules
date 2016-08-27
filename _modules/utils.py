from itertools import izip
from copy import deepcopy
import socket
import re

def is_bool(obj):
    return isinstance(obj, bool) and not isinstance(obj, int)

def dict_to_dictlist(d):
    return [{k: v} for k, v in d.items()]

def dictlist_to_dict(l):
    res = {}
    for d in l:
        if len(d) != 1:
            raise ValueError("Not a dictlist!")
        for k, v in d.items():
            res[k] = v
    return res

NET_REMAP = {'ip': 'ip_address'}
def remap(k):
    if k in NET_REMAP:
        return NET_REMAP[k]
    return k

NET_PARAMS = ['name', 'bridge', 'gw', 'ip', 'type', 'ip6', 'hwaddr', 'tag']
KEEP_ANYWAY = ['name']

def filter_netparams(param_dictlist):
    return [{remap(k): v} for d in param_dictlist for k, v in d.items() if k not in NET_PARAMS or k in KEEP_ANYWAY]

def mknet(name='eth0', bridge='vmbr0', gw=None, ip=None, type='veth', **kwargs):
    if ip and '/' not in ip:
        ip += '/24'

    if gw:
        kwargs['gw'] = gw

    if ip:
        kwargs['ip'] = ip

    kwargs.update({
        'name': name,
        'bridge': bridge,
        'type': type
    })

    return ','.join(['='.join((k,str(v))) for k, v in kwargs.items() if k in NET_PARAMS])

def is_list(obj):
    return isinstance(obj, list)

def is_dict(obj):
    return isinstance(obj, dict)

def is_ip(obj):
    return is_str(obj) and re.match('^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$', obj)

def is_str(obj):
    return isinstance(obj, str)

def bool_lc(obj):
    return "true" if obj else "false"

def is_int(obj):
    return isinstance(obj, int)

def grouped(iterable, n):
    return izip(*[iter(iterable)]*n)

def pairwise(l):
    return grouped(l, 2)

def exclude_keys(dic, *keys):
    return {k: v for k, v in dic.iteritems() if k not in keys}

def copy(dic):
    return deepcopy(dic)

def is_listdict(d):
    return isinstance(d, list) and all((isinstance(n, dict) and len(n) == 1 for n in d))

def resolve(hostname):
    return socket.gethostbyname(hostname)

def merge_listdict(a, b):
    "merges b into a"

    a_dict = {}
    b_dict = {}

    for elm in a:
        a_dict.update(elm)

    for elm in b:
        b_dict.update(elm)

    res_dict = merge(a_dict, b_dict)

    return [{k: v} for k, v in res_dict.items()]

def merge(a, b, path=None):
    "merges b into a"
    if path is None: path = []

    if is_listdict(a) and is_listdict(b):
        return merge_listdict(a, b)
    else:
        for key in b:
            if key in a:
                if isinstance(a[key], dict) and isinstance(b[key], dict):
                    merge(a[key], b[key], path + [str(key)])
                elif a[key] == b[key]:
                    pass # same leaf value
                else:
                    a[key] = b[key]
            else:
                a[key] = b[key]
        return a
