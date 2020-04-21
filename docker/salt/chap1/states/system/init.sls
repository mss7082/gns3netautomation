Manage the system config:
  netconfig.managed:
    - template_name: salt://templates/{{salt.grains.get("os")}}/system.j2
    # - commit_in: 1m