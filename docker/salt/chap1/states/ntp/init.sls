Manage the NTP config:
  netntp.managed:
    - template_name: salt://states/ntp/templates/init.j2
    - peers: {{ salt.pillars.get("ntp.peers") }}
    - servers: {{ salt.pillars.get("ntp.servers") }}