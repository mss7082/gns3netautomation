import re


def first():
    return True


def second():
    return __salt__["test.false"]()


def third():
    return __salt__["sample.first"]()


def users():
    users = []
    pattern = re.compile(r"user\s[\w]+")
    res = __salt__["napalm.netmiko_commands"](
        "show configuration system login")
    matches = pattern.findall(res[0])
    for match in matches:
        users.append(match.split(" ")[1])
    return users
