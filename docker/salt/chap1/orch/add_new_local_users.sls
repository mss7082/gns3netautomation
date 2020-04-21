

# Check the user is not yet configured.
# Save current config or save rescue if junos
# Make the changes
# Check the user is now configured
# On failure
# Roll back from save rescue or saved config.

{% set targets = "r[12]"%}
{% set user = "inetzero"%}

check_new_user_not_exist:
  salt.function:
    - tgt: {{targets}}
    - name: general.check_user_not_configured
    - arg:
      - user: {{user}}


push_user_changes:
  salt.function:
    - tgt: {{targets}}
    - name: netconfig.managed
    - arg:
      - template_name: salt://templates/{{salt.grains.get("os")}}/system.j2
      - commit_in: 1m


verify_access_to_device:
  salt.function:
    - tgt: {{targets}}
    - name: net.ping
    - arg:
      - {{pillar.proxy.host}}
      - count: 5
    - onfail:
      - 

rollback_config:
  salt.function:
    - tgt: {{targets}}
    - name: net.rollback

    





