---
Manage device local users:
  netusers.managed:
    - users:
        admin:
          class: super-user
          password: "salt123"
        martin:
          class: super-user
          password: "salt123"
        jonathan:
          class: super-user
          password: "salt123"
