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
        if "salt" in lines:
            users.append(lines)
        else:
            return "None found"
    return users
