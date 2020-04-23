{% set targets = "r[12]"%}
{% set user = "inetzero"%}
{% set prefix = "172.16.1.0/24"%}
{% set dummy_prefix = "6.6.6.6/32"%}

check_new_user_not_exist:
  salt.function:
    - tgt: {{targets}}
    - name: general.user_not_configured
    - arg:
      - user: {{user}}


check_prefix_is_active:
  salt.function:
    - tgt: {{targets}}
    - name: routes.prefix_active_in_route_table
    - arg:
      - prefix: {{"prefix"}}



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
check_prefix_is_not_active:
  salt.function:
    - tgt: {{targets}}
    - name: routes.prefix_not_active_in_route_table
    - arg:
      - prefix: {{"dummy_prefix"}}

check_user_is_configured:
  salt.function:
    - tgt: {{targets}}
    - name: general.user_configured
    - arg:
      - user: {{user}}
