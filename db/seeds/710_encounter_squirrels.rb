Encounter.where(
    message: "You find a young lady with a wagon full of caged squirrels."
).first_or_create(
    short_name: "Squirrel Vendor",
    skip_on_flags: Player.flag_mapping["flags"][:freed_squirrels] | Player.flag_mapping["flags"][:hamster],
    flags_required: 0,
    choice_1: {
        action: "Buy (1 jewel)",
        cost: { gold: 0, jewels: 1 },
        effects: [{ chance: 70,
                    message: "You obtain a squirrel.",
                    results: [{ name: "Jewels", value: -1 }, { name: "Trinket", value: "Squirrel" }, { name: "Flag", value: Player.flag_mapping["flags"][:squirrel] }]
                  },
                  { chance: 30,
                    message: "You buy the squirrel, but it runs off as soon as you open the cage.",
                    results: [{ name: "Jewels", value: -1 }, { name: "Flag", value: Player.flag_mapping["flags"][:lost_squirrel] }]
                  }]
    },
    choice_2: {
        action: "Free them",
        effects: [{ chance: 50,
                    message: "The squirrels scatter into the woods.  You gain %s exp.",
                    results: [{ name: "LvlExp", value: 0.1 }, { name: "Flag", value: Player.flag_mapping["flags"][:freed_squirrels] }]
                  },
                  { chance: 50,
                    message: "She clubs you as you attempt to free the squirrels.  You take %s damage.",
                    results: [{ name: "CurrentHP", value: -0.25 }]
                  }]
    },
    choice_3: {
        action: "Leave",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }]
                  }]
    }
)

Encounter.where(
    message: "You find a young lady with a wagon full of caged squirrels.  She scowls at your hamster."
).first_or_create(
    short_name: "Squirrel Vendor",
    skip_on_flags: Player.flag_mapping["flags"][:freed_squirrels],
    flags_required: Player.flag_mapping["flags"][:hamster],
    choice_1: {
        action: "Buy (4 jewel)",
        cost: { gold: 0, jewels: 4 },
        effects: [{ chance: 30,
                    message: "You obtain a squirrel.",
                    results: [{ name: "Jewels", value: -4 }, { name: "Trinket", value: "Squirrel" }, { name: "Flag", value: Player.flag_mapping["flags"][:squirrel] }]
                  },
                  { chance: 70,
                    message: "You buy the squirrel, but it runs off as soon as you open the cage.",
                    results: [{ name: "Jewels", value: -4 }, { name: "Flag", value: Player.flag_mapping["flags"][:lost_squirrel] }]
                  }]
    },
    choice_2: {
        action: "Free them",
        effects: [{ chance: 25,
                    message: "The squirrels scatter into the woods.  You gain %s exp.",
                    results: [{ name: "LvlExp", value: 0.1 }, { name: "Flag", value: Player.flag_mapping["flags"][:freed_squirrels] }]
                  },
                  { chance: 75,
                    message: "She clubs you as you attempt to free the squirrels.  You take %s damage.",
                    results: [{ name: "CurrentHP", value: -0.25 }]
                  }]
    },
    choice_3: {
        action: "Leave",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }]
                  }]
    }
)

Encounter.where(
    message: "A squirrel brings a ring to you."
).first_or_create(
    short_name: "Squirrel",
    skip_on_flags: Player.flag_mapping["flags"][:obtained_ring_speed],
    flags_required: Player.flag_mapping["flags"][:lost_squirrel],
    choice_1: {
        action: "Take it",
        effects: [{ chance: 100,
                    message: "You obtain a ring.",
                    results: [{ name: "Trinket", value: "Ring of Speed" }, { name: "Flag", value: Player.flag_mapping["flags"][:obtained_ring_speed] }]
                  }]
    },
    choice_2: {
        action: "Leave",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }]
                  }]
    }
)

Encounter.where(
    message: "You find a squirrel horde of nuts, gold, and jewels."
).first_or_create(
    short_name: "Squirrel Horde",
    skip_on_flags: 0,
    flags_required: Player.flag_mapping["flags"][:freed_squirrels],
    choice_1: {
        action: "Loot it",
        effects: [{ chance: 50,
                    message: "You obtain %s gold and %s jewel.",
                    results: [{ name: "LvlGold", value: 0.1 }, { name: "Jewels", value: 1 }]
                  },
                  { chance: 50,
                    message: "You obtain %s gold and %s jewels.",
                    results: [{ name: "LvlGold", value: 0.05 }, { name: "Jewels", value: 2 }]
                  }]
    },
    choice_2: {
        action: "Leave",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }]
                  }]
    }
)
