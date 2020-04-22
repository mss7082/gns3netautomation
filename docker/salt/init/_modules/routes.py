def prefix_active_in_route_table(prefix, **kwargs):
    '''
    Returns true if prefix is active in the route table

    Supports;
        junos
        ios


    CLI Example::

        salt '*' routes.prefix_active_in_route_table 1.1.1.1/32

    '''
    if (__grains__["os"] == "ios") or (__grains__["os"] == "junos"):
        res = __salt__["route.show"](prefix)
        if res["out"][prefix]["current_active"] == "true":
            return True
        else:
            return False
    else:
        return (False, "Os is not supported")


def prefix_not_active_in_route_table(prefix, **kwargs):
    '''
    Returns true if prefix is not active in the route table

    Supports;
        junos
        ios


    CLI Example::

        salt '*' routes.prefix_not_active_in_route_table 1.1.1.1/32

    '''
    if (__grains__["os"] == "ios") or (__grains__["os"] == "junos"):
        res = __salt__["route.show"](prefix)
        if res["out"][prefix]["current_active"] == "true":
            return False
        else:
            return True
    else:
        return (False, "Os is not supported")
