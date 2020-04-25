# Sample from https://gist.github.com/whiteinge/1bf3b1fa525c2e883b805f271ec6f7d7
# /srv/salt/upgrade_the_app.sls
# Example of a complex, multi-host Orchestration state that performs status checks as it goes.
# Note, this is untested and is meant to serve as an example.
# Run via: salt-run state.orch upgrade_the_app pillar='{nodes: [nodeA, nodeB], version: 123}'

{% set nodes = salt.pillar.get('nodes', []) %}
{% set all_grains = salt.saltutil.runner('cache.grains',
    tgt=','.join(nodes), tgt_type='list') %}

{# Default version if not given at the CLI. #}
{% set version = salt.pillar.get('version', 1.0) %}

{# Hard-code or pass in via Pillar like version. #}
{% set haproxy_node = 'firewall-1' %}
{% set app_name = 'myApp' %}

{% for node in nodes %}
    {# Since we're using a loop to generate a lot of states we make a macro to
    generate unique state IDs that we can easily reuse. #}
    {%- macro gen_id(name) -%}
    {{ name }}_{{ node }}_{{ loop.index }}
    {%- endmacro -%}

    {# Start with a little error-checking and abort if we're missing data. #}
    {% if node not in all_grains %}
        {% do salt.test.exception('Incorrect node name or missing grains.') %}
    {% endif %}

    {# Probably want something more robust here than just looking for eth0. #}
    {% set ipaddrs = all_grains[node].get('ip4_interfaces', {}).get('eth0', []) %}
    {% if not ipaddrs %}
        {% do salt.test.exception('Could not determine primary IP for node: '~ node) %}
    {% endif %}
    {% set ip = ipaddrs | first() %}

    {# Disable the server we're upgrading in haproxy first. See the prereq in
    the next state which governs whether this step needs to happen at all. #}
    {% set stop_haproxy = gen_id('stop_haproxy') %}
    {{ stop_haproxy }}:
      salt.function:
        - tgt: {{ haproxy_node }}
        - name: haproxy.disable_server
        - arg:
          - {{ node }}
          - {{ app_name }}

    {# Deploy the application by kicking off a highstate and passing the
    desired version through as a Pillar value. Due to the prereq, highstate
    will first be executed in dry-run mode then executed for real. #}
    {% set upgrade_app = gen_id('upgrade_app') %}
    {{ upgrade_app }}:
      salt.state:
        - tgt: {{ node }}
        - highstate: True
        - pillar:
            version: {{ version | json() }}
        {# Using prereq here prevents stopping haproxy if the highstate run
        above will not produce any changes! I.e., if we're already running the
        right version then the Orchestrate loop for this node does nothing. #}
        - prereq_in:
          - salt: {{ stop_haproxy }}

    {# Wait for the new application to become available by repeatedly trying to
    connect to the host and port that it will be running on. #}
    {% set wait_for_app_to_become_available = gen_id('wait_for_app_to_become_available') %}
    {{ wait_for_app_to_become_available }}:
      module.run:
        - name: network.connect
        - host: {{ ip }}
        - port: 8080
        - retry:
            attempts: 5
            interval: 20
        - require:
          - salt: {{ stop_haproxy }}

    {# Add the node back to haproxy once it's available. #}
    {% set start_haproxy = gen_id('start_haproxy') %}
    {{ start_haproxy }}:
      salt.function:
        - tgt: {{ haproxy_node }}
        - name: haproxy.enable_server
        - arg:
          - {{ node }}
          - {{ app_name }}
        - require:
          - module: {{ wait_for_app_to_become_available }}

    {# And finally try to connect to the website to verify everything above
    worked before moving on to the next node. #}
    {% set verify_node_is_back = gen_id('verify_node_is_back') %}
    {{ verify_node_is_back }}:
      http.wait_for_successful_query:
        - name: 'http://example.com'
        - status: 200
        - match: '<h1>Widgets and Things</h1>'
        - request_interval: 20
        - require:
          - salt: {{ start_haproxy }}

    {# If the website did not come up successfully, bark to Slack then halt. #}
    {% set notify_slack_of_failure = gen_id('notify_slack_of_failure') %}
    {{ notify_slack_of_failure }}:
      slack.post_message:
        - channel: '#ops'
        - from_name: Your Friendly Orchestrate Run
        - message: 'Error deploying to node: {{ node }}'
        - api_key: XXXX-YYYY
        - onfail:
          - http: {{ verify_node_is_back }}

    {% set halt_orchestrate = gen_id('halt_orchestrate') %}
    {{ halt_orchestrate }}:
      module.run:
        - name: test.exception
        - message: 'Error deploying to node: {{ node }}'
        {# failhard here will abort the Orchestrate run early. #}
        - failhard: True
        - require:
          - slack: {{ notify_slack_of_failure }}

{% endfor %}