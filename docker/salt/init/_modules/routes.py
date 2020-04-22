def prefix_active_in_route_table(prefix, **kwargs):
    '''
    Returns true if prefix is active in the route table

    Supports;
        junos
        ios


    CLI Example::

        salt '*' routes.prefix_active_in_route_table 1.1.1.1/32

    '''
    result_list = []
    if (__grains__["os"] == "ios") or (__grains__["os"] == "junos"):
        res = __salt__["route.show"](prefix)
        for protocol_list in res["out"][prefix]:
            result_list.append(protocol_list["current_active"])
    else:
        return (False, "Os is not supported")
    if result_list.count(True) >= 1:
        return True
    else:
        return False


def prefix_not_active_in_route_table(prefix, **kwargs):
    '''
    Returns true if prefix is not active in the route table

    Supports;
        junos
        ios


    CLI Example::

        salt '*' routes.prefix_not_active_in_route_table 1.1.1.1/32

    '''
    result_list = []
    if (__grains__["os"] == "ios") or (__grains__["os"] == "junos"):
        res = __salt__["route.show"](prefix)
        for protocol_list in res["out"][prefix]:
            result_list.append(protocol_list["current_active"])
    else:
        return (False, "Os is not supported")
    if result_list.count(True) >= 1:
        return False
    else:
        return True
