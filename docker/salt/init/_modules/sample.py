def first():
    return True


def second():
    return __salt__["test.false"]()


def third():
    return __salt__["sample.first"]()
