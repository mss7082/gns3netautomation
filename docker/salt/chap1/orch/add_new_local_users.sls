check_new_user_not_exist:
  salt.function:
    - name: users.config
    - tgt: "*"
    - arg: 
