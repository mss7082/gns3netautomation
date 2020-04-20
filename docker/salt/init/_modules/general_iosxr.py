import re


def __virtual__():
    if __grains__["os"] == "iosxr":
        return "general"
    else:
        return (False, 'Not loading this module, as this is not an iosxr device')


def get_users():
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


def check_user_not_configured(user=None, **kwargs):
    '''
    Takes a user argument and returns True if user is not configured on the target

    Supports;
        junos
        ios
        iosxr


    CLI Example::

        salt '*' general.check_users_not_configured user=salt_user

    '''
    users_on_device = get_users()
    if user in users_on_device:
        return False
    else:
        return True


def check_user_configured(user=None, **kwargs):
    '''
    Takes a user argument and returns True if user is configured on the target

    Supports;
        junos
        ios
        iosxr


    CLI Example::

        salt '*' general.check_user_configured user=salt_user

    '''
    users_on_device = get_users()
    if user in users_on_device:
        return True
    else:
        return False
