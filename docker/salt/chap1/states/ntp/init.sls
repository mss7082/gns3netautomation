Manage the NTP config:
  netntp.managed:
    - template_name: salt://chap1/templates/junos/ntp.j2
    - peers: {{ salt.pillar.get("ntp.peers") }}
    - servers: {{ salt.pillar.get("ntp.servers") }}