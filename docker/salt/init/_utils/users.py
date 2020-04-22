import re


def get_users():
    '''
    Returns a list of users configured on network devices.

    Supports;
        junos
        ios
        iosxr

    NOTE: This function does not return root user on junos nor admin user on iosxr.
    '''

    users = []
    pattern = re.compile(r"username\s[\w]+")
    if __grains__["os"] == "ios":
        res = __salt__["napalm.netmiko_commands"](
            "show run | i  username")
    elif __grains__["os"] == "junos":
        res = __salt__["napalm.netmiko_commands"](
            "show configuration system login")
    elif __grains__["os"] == "iosxr":
        res = __salt__["napalm.netmiko_commands"](
            "show run username")
    else:
        return (False, "This function is not supported yet on this platform")
    matches = pattern.findall(res[0])
    for match in matches:
        users.append(match.split(" ")[1])
    return users
