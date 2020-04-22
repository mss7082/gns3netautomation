def route_active_in_route_table(route=None, **kwargs):
    '''
    Returns true if route is active in the route table

    Supports;
        junos
        ios


    CLI Example::

        salt '*' routes.route_active_in_route_table 1.1.1.1/32

    '''
    if __grains__["os"] != "ios" or __grains__["os"] != "junos":
        return (False, "Os is not supported")
    res = __salt__["route.show"](route)
    if res["out"][route]["current_active"] == "true":
        return True
    else:
        return False


def route_not_active_in_route_table(route=None, **kwargs):
    '''
    Returns true if route is not active in the route table

    Supports;
        junos
        ios


    CLI Example::

        salt '*' routes.route_not_active_in_route_table 1.1.1.1/32

    '''
    if __grains__["os"] != "ios" or __grains__["os"] != "junos":
        return (False, "Os is not supported")
    res = __salt__["route.show"](route)
    if res["out"][route]["current_active"] == "true":
        return False
    else:
        return True
