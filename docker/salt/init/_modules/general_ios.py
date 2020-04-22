import re


def __virtual__():
    if __grains__["os"] == "ios":
        return "general"
    else:
        return (False, 'Not loading this module, as this is not an ios device')


def user_not_configured(user=None, **kwargs):
    '''
    Takes a user argument and returns True if user is not configured on the target

    Supports;
        junos
        ios
        iosxr


    CLI Example::

        salt '*' general.user_not_configured user=salt_user

    '''
    users_on_device = __utils__['users.get_users']()
    if user in users_on_device:
        return False
    else:
        return True


def user_configured(user=None, **kwargs):
    '''
    Takes a user argument and returns True if user is configured on the target

    Supports;
        junos
        ios
        iosxr


    CLI Example::

        salt '*' general.user_configured user=salt_user

    '''
    users_on_device = __utils__['users.get_users']()
    if user in users_on_device:
        return True
    else:
        return False
