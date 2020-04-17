interfaces:
  - gigabitEthernet1:
      ipv4addr: 10.10.1.1/24
      ipv6addr: 2001:db8:0:5::3/64
      subintfs:
        "999":
          ipv4addr: 30.10.1.1/24
          ipv6addr: 2001:db8:0:5::1/64 