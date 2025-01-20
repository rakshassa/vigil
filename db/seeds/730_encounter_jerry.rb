Encounter.where(
    message: "This guy has a long trench coat.  The pockets are moving on their own."
).first_or_create(
    short_name: "Toothless Jerry",
    skip_on_flags: Player.flag_mapping["flags"][:squirrel],
    flags_required: 0,
    choice_1: {
        action: "Buy a Hamster (1 jewel)",
        cost: { gold: 0, jewels: 1 },
        effects: [{ chance: 70,
                    message: "You obtain a hamster.",
                    results: [{ name: "Jewels", value: -1 }, { name: "Trinket", value: "Hamster" }, { name: "Flag", value: Player.flag_mapping["flags"][:hamster] }]
                  },
                  { chance: 30,
                    message: "You realize this hamster is already dead.  What a scam!",
                    results: [{ name: "Jewels", value: -1 }]
                  }]
    },
    choice_2: {
        action: "Buy something (1 jewel)",
        cost: { gold: 0, jewels: 1 },
        effects: [{ chance: 35,
                    message: "Jerry digs in his pockets and sells you a %s.",
                    results: [{ name: "Trinket", value: "Random" }, { name: "Jewels", value: -1 }]
                  },
                  { chance: 25,
                    message: "Jerry hands you his whittling knife and smiles his toothless grin.",
                    results: [{ name: "Jewels", value: -1 }, { name: "Trinket", value: "Pocket Knife" }]
                  },
                  { chance: 40,
                    message: "Jerry tells you a story and then wanders off.  At least he didn't take your money.  You gain %s exp.",
                    results: [{ name: "LvlExp", value: 0.05 }]
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
    message: "This guy has a long trench coat.  The pockets are moving on their own. He steps back when he sees your squirrel."
).first_or_create(
    short_name: "Toothless Jerry",
    skip_on_flags: 0,
    flags_required: Player.flag_mapping["flags"][:squirrel],
    choice_1: {
        action: "Buy a Hamster (4 jewel)",
        cost: { gold: 0, jewels: 4 },
        effects: [{ chance: 50,
                    message: "You obtain a hamster.",
                    results: [{ name: "Jewels", value: -4 }, { name: "Trinket", value: "Hamster" }, { name: "Flag", value: Player.flag_mapping["flags"][:hamster] }]
                  },
                  { chance: 50,
                    message: "You realize this hamster is already dead.  What a scam!",
                    results: [{ name: "Jewels", value: -4 }]
                  }]
    },
    choice_2: {
        action: "Buy something (1 jewel)",
        cost: { gold: 0, jewels: 1 },
        effects: [{ chance: 25,
                    message: "Jerry digs in his pockets and sells you a %s.",
                    results: [{ name: "Trinket", value: "Random" }, { name: "Jewels", value: -1 }]
                  },
                  { chance: 25,
                    message: "Jerry hands you his whittling knife and smiles his toothless grin.",
                    results: [{ name: "Jewels", value: -1 }, { name: "Trinket", value: "Pocket Knife" }]
                  },
                  { chance: 50,
                    message: "He mumbles under his breath and starts coughing uncontrollably.  You flee.",
                    results: [{ name: "Jewels", value: -1 }]
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
