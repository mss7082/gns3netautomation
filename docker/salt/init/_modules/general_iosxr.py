import re


def __virtual__():
    if __grains__["os"] == "iosxr":
        return "general"
    else:
        return (False, 'Not loading this module, as this is not an iosxr device')


def users():
    '''
    Returns a list of users configured on network devices.

    Supports;
        junos
        ios
        iosxr

    NOTE: This function does not return root user on junos nor admin user on iosxr.

    CLI Example::

        salt '*' general.users

    '''
    users = []
    pattern = re.compile(r"username\s[\w]+")
    res = __salt__["napalm.netmiko_commands"](
        "show run username")
    matches = pattern.findall(res[0])
    for match in matches:
        users.append(match.split(" ")[1])
    return users
