import re


def first():
    return True


def second():
    return __salt__["test.false"]()


def third():
    return __salt__["sample.first"]()


def users():
    res = __salt__["napalm.netmiko_commands"](
        "show configuration system login")
    matches = re.findall(r"user", res[0], re.MULTILINE)
    return matches
