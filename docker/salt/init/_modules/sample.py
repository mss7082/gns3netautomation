import re


def first():
    return True


def second():
    return __salt__["test.false"]()


def third():
    return __salt__["sample.first"]()


def users():
    pattern = re.compile(r"user\s[\w]+")
    res = __salt__["napalm.netmiko_commands"](
        "show configuration system login")
    return pattern.findall(res)
