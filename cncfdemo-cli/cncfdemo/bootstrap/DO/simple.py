#!/usr/bin/env python

import time
import requests

# TODO: paramatize constants, intergrate as subcomand of cncfdemo-cli, add flag for master

DESIRED = 3
image = 22597876
token = ''

API_URL = 'https://api.digitalocean.com/v2/droplets'
headers = {'Content-Type': 'application/json',
           'Authorization': 'Bearer {}'.format(token)}

names = ['Minion{}'.format(num) for num in range(1, DESIRED + 1)]
data = {'image': image, 'names': names, 'region': 'nyc3', 'size': '512mb', 'private_networking': True}

r = requests.post(API_URL, headers=headers, json=data)

droplets = [(d['id'], d['name'],d['networks']['v4']) for d in r.json().get('droplets')]
active = []

for droplet in droplets:
  droplet_id, name, private_ip = droplet
  while not private_ip:
    resp = requests.get(API_URL + '/' + str(droplet_id), headers=headers)
    try:
      private_ip = resp.json()['droplet']['networks']['v4'][0]['ip_address']
      active.append((droplet_id, name, private_ip))
    except:
      time.sleep(3)


print active
# TODO: droplet hostname/private_ip pairs need to be registered with external endpoint so DNS discovery works and cluster can boot.
