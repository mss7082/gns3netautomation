{% set targets = "r[12]"%}
{% set user = "inetzero"%}

check_new_user_not_exist:
  salt.function:
    - name: general.check_user_not_configured
    - tgt: {{targets}}
    - argsalt.function:
      - user: {{user}}
