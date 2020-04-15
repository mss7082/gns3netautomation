Manage the NTP config:
  netntp.managed:
    - name: salt://chap1/templates/{{salt.grains.get("os")}}/ntp.j2
    - peers: {{ salt.pillar.get("ntp.peers") }}
    - servers: {{ salt.pillar.get("ntp.servers") }}