Encounter.where(
    message: "An old man asks you to help him get back to town."
).first_or_create(
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

