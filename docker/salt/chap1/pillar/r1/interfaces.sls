# TO DO - Create custom module/jinja2 filters to calculate min-links from the # of lag members
interfaces:
  - ge-0/0/0.0:
      description: This is a link
      mtu: 
      ipv4addr:
        - 10.10.1.1/24
        - 20.10.1.1/24
      ipv6addr:
        - 2001:db8:0:5::1/64
        - 2001:db8:0:6::1/65
  - ae0.0:
      description: This is a link too
      members:
        - ge-0/0/1
        - ge-0/0/2
      ipv4addr:
        - 10.1.12.1/24
      min_links: "2"
      mtu: 9192
  - lo0.0:
      description: Loopback interface
      ipv4addr:
        - 1.1.1.1/32
  - fxp0.0:
      description: Mgmt Interface
      ipv4addr:
        - 172.16.1.11/24

