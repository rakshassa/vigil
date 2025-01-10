Encounter.where(
    message: "An old man asks you to help him get back to town."
).first_or_create(
    skip_on_flags: Player.flag_mapping["flags"][:avoided_old_man],
    flags_required: 0,
    choice_1: {
        action: "Help Him",
        effects: [{ chance: 70,
                    message: "He pays you %s gold for your service.",
                    results: [{ name: "LvlGold", value: 0.4 }]
                  },
                  { chance: 30,
                    message: "He explains his combat style as you walk. You gain %s exp.",
                    results: [{ name: "LvlExp", value: 0.2 }]
                  }]
    },
    choice_2: {
        action: "Rob Him",
        effects: [{ chance: 50,
                    message: "You pilfer %s gold coins and %s jewels.",
                    results: [{ name: "LvlGold", value: 0.6 }, { name: "Jewels", value: 2 }]
                  },
                  { chance: 50,
                    message: "He smacks you across the face for %s damage and vanishes. It really hurts!",
                    results: [{ name: "CurrentHP", value: -0.5 }]
                  }]
    },
    choice_3: {
        action: "Avoid Him",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }, { name: "Flag", value: Player.flag_mapping["flags"][:avoided_old_man] }]
                  }]
    }
)

Encounter.where(
    message: "The man you abandoned lies bleeding in the dirt."
).first_or_create(
    skip_on_flags: Player.flag_mapping["flags"][:killed_old_man],
    flags_required: Player.flag_mapping["flags"][:avoided_old_man],
    choice_1: {
        action: "Help Him",
        effects: [{ chance: 70,
                    message: "He pays you %s gold for your service.",
                    results: [{ name: "LvlGold", value: 0.4 }]
                  },
                  { chance: 30,
                    message: "He explains his combat style as you walk. You gain %s exp.",
                    results: [{ name: "LvlExp", value: 0.2 }]
                  }]
    },
    choice_2: {
        action: "Rob Him",
        effects: [{ chance: 50,
                    message: "You pilfer %s gold coins and %s jewels.",
                    results: [{ name: "LvlGold", value: 0.6 }, { name: "Jewels", value: 2 }]
                  },
                  { chance: 50,
                    message: "He smacks you across the face for %s damage and vanishes. It really hurts!",
                    results: [{ name: "CurrentHP", value: -0.5 }]
                  }]
    },
    choice_3: {
        action: "Kill Him",
        effects: [{ chance: 100,
                    message: "You put him out of his misery.",
                    results: [{ name: "Flag", value: Player.flag_mapping["flags"][:killed_old_man] }]
                  }]
    }
)


Encounter.where(
    message: "The old man's ghost beckons you."
).first_or_create(
    skip_on_flags: 0,
    flags_required: Player.flag_mapping["flags"][:killed_old_man],
    choice_1: {
        action: "Approach",
        effects: [{ chance: 30,
                    message: "He touches you - chilling you to the bone. You lose %s max HP.",
                    results: [{ name: "MaxHP", value: -0.1 }]
                  },
                  { chance: 70,
                    message: "He forgives you. You gain %s exp and fully heal.",
                    results: [{ name: "LvlExp", value: 0.1 }, { name: "FullHeal", value: 100 }]
                  }]
    },
    choice_2: {
        action: "Attack",
        effects: [{ chance: 50,
                    message: "He touches you - chilling you to the bone. You lose %s max HP.",
                    results: [{ name: "MaxHP", value: -0.1 }]
                  },
                  { chance: 50,
                    message: "He disperses into fog leaving some valuables behind.  You gain %s gold and %s jewels.",
                    results: [{ name: "LvlGold", value: 0.2 }, { name: "Jewels", value: 1 }]
                  }]
    },
    choice_3: {
        action: "Flee",
        effects: [{ chance: 100,
                    message: "He shakes his head and disappears.  You gain %s exp.",
                    results: [{ name: "LvlExp", value: 0.1 }]
                  }]
    }
)
