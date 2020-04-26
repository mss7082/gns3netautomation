{% set users = salt.pillar.get["users"] %}

Manage device local users:
  netusers.managed:
    - users:
      {% for user in users %}

      {{user}}:

        {% if user.class -%}
        class: {{user.class}}
        {% endif %}

        {% if user.uid %}
        uid: {{user.uid}}
        {% endif %}
        password:
          {{user.password}}
       
      {% endfor %}