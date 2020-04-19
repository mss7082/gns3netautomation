import re


def first():
    return True


def second():
    return __salt__["test.false"]()


def third():
    return __salt__["sample.first"]()


def users():
    users = []
    res = __salt__["napalm.netmiko_commands"](
        "show configuration system login")
    for lines in res[0]:
        for user in re.findaall(r'user[\w\.-]+', lines):
            users.append(user)
    return users


0
