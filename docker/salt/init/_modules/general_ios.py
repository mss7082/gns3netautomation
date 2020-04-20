import re


def __virtual__():
    if __grains__["os"] == "ios":
        return "general"
    else:
        return (False, 'Not loading this module, as this is not an ios device')


def users():
    '''
    Returns a list of users configured on network devices.

    Supports;
        junos
        ios
        iosxr

    CLI Example::

        salt '*' general.users

    '''
    users = []
    pattern = re.compile(r"user\s[\w]+")
    res = __salt__["napalm.netmiko_commands"](
        "show run | i  username")
    matches = pattern.findall(res[0])
    for match in matches:
        users.append(match.split(" ")[1])
    return users
