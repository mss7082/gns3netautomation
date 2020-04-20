{% set targets = "r[12]"%}

check_new_user_not_exist:
  salt.function:
    - name: general.users
    - tgt: {{targets}}
