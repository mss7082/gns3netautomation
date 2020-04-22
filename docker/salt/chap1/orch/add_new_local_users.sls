{% set targets = "r[12]"%}
{% set user = "inetzero"%}

check_new_user_not_exist:
  salt.function:
    - tgt: {{targets}}
    - name: general.user_not_configured
    - arg:
      - user: {{user}}


push_user_changes:
  salt.state:
    - tgt: {{targets}}
    - sls:
      - states.system


# verify_access_to_device:
#   salt.function:
#     - tgt: {{targets}}
#     - name: net.ping
#     - arg:
#       - 172.16.1.1
#       - count: 5

# rollback_config:
#   salt.function:
#     - tgt: {{targets}}
#     - name: net.rollback
#     - onfail_any:
#       - net: verify_access_to_device
#       - general: check_new_user_exist


# CANCEL COMMIT


# COMMIT


check_new_user_exist:
  salt.function:
    - tgt: {{targets}}
    - name: general.user_configured
    - arg:
      - user: {{user}}
    - retry: True





