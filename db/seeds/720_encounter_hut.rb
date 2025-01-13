Encounter.where(
    message: "You see a wooden shack."
).first_or_create(
    short_name: "Shack",
    skip_on_flags: 0,
    flags_required: 0,
    choice_1: {
        action: "Knock",
        effects: [{ chance: 25,
                    message: "Nobody answers, so you wander off.",
                    results: []
                  },
                  { chance: 25,
                    message: "A kindly old grandmother invites you in.  You warm yourself at the fire and are fully healed.",
                    results: [{ name: "FullHeal", value: "1" }, { name: "Flag", value: Player.flag_mapping["flags"][:grandma_happy] }]
                  },
                  { chance: 50,
                    message: "Stephen peers out from a window and bellows at you to 'get off his lawn!'",
                    results: [{ name: "Flag", value: Player.flag_mapping["flags"][:angry_stephen] }]
                  }]
    },
    choice_2: {
        action: "Break In",
        effects: [{ chance: 5,
                    message: "The house comes to life and takes a big bite out of you before you run away screaming.  You take %s damage.",
                    results: [{ name: "CurrentHP", value: -0.5 }]
                  },
                  { chance: 35,
                    message: "You set off a trap taking %s damage.",
                    results: [{ name: "CurrentHP", value: -0.25 }]
                  },
                  { chance: 35,
                    message: "You find a box of %s gold.",
                    results: [{ name: "LvlGold", value: 0.5 }]
                  },
                  { chance: 25,
                    message: "You find nothing valuable, so you set the house on fire.",
                    results: [{ name: "Flag", value: Player.flag_mapping["flags"][:burned_house] }]
                  }]
    },
    choice_3: {
        action: "Avoid It",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }]
                  }]
    }
)

Encounter.where(
    message: "A tiny grandmother is picking berries."
).first_or_create(
    short_name: "Grandmother",
    skip_on_flags: Player.flag_mapping["flags"][:grandma_scared],
    flags_required: Player.flag_mapping["flags"][:grandma_happy],
    choice_1: {
        action: "Help Her",
        effects: [{ chance: 45,
                    message: "She pays you for your kind deed.  You gain %s gold and %s exp.",
                    results: [{ name: "LvlExp", value: 0.1 }, { name: "LvlGold", value: 0.1 }]
                  },
                  { chance: 55,
                    message: "She feeds you delicious berries.  You gain %s max HP.",
                    results: [{ name: "MaxHP", value: 0.1 }]
                  }]
    },
    choice_2: {
        action: "Rob Her",
        effects: [
                  { chance: 65,
                    message: "She screams for help. Soldiers come running.  You drop your %s as you run away.",
                    results: [{ name: "LoseTrinket", value: 1 }, { name: "Flag", value: Player.flag_mapping["flags"][:grandma_scared] }]
                  },
                  { chance: 35,
                    message: "You take all of her coins.  You gain %s gold.",
                    results: [{ name: "LvlGold", value: 0.2 }, { name: "Flag", value: Player.flag_mapping["flags"][:grandma_scared] }]
                  }]
    },
    choice_3: {
        action: "Ignore Them",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }]
                  }]
    }
)

Encounter.where(
    message: "You see seven dwarves covered in ashes."
).first_or_create(
    short_name: "Dwarves",
    skip_on_flags: 0,
    flags_required: Player.flag_mapping["flags"][:burned_house],
    choice_1: {
        action: "Smile",
        effects: [{ chance: 45,
                    message: "They smile politely back at you.  You gain %s exp from learning manners.",
                    results: [{ name: "LvlExp", value: 0.2 }]
                  },
                  { chance: 55,
                    message: "They realize you burned down their house and mug you. You lose all your gold.",
                    results: [{ name: "LvlGold", value: -2 }]
                  }]
    },
    choice_2: {
        action: "Attack",
        effects: [
                  { chance: 65,
                    message: "They pummel you for %s damage.",
                    results: [{ name: "CurrentHP", value: -0.35 }]
                  },
                  { chance: 35,
                    message: "They bribe you to leave them alone.  You gain %s gold.",
                    results: [{ name: "LvlGold", value: 0.2 }]
                  }]
    },
    choice_3: {
        action: "Ignore Them",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }]
                  }]
    }
)

Encounter.where(
    message: "You see seven dwarves."
).first_or_create(
    short_name: "Dwarves",
    skip_on_flags: Player.flag_mapping["flags"][:burned_house],
    flags_required: 0,
    choice_1: {
        action: "Smile",
        effects: [{ chance: 100,
                    message: "They smile politely back at you.  You gain %s exp from learning manners.",
                    results: [{ name: "LvlExp", value: 0.2 }]
                  }]
    },
    choice_2: {
        action: "Attack",
        effects: [
                  { chance: 65,
                    message: "They pummel you for %s damage.",
                    results: [{ name: "CurrentHP", value: -0.35 }]
                  },
                  { chance: 35,
                    message: "They bribe you to leave them alone.  You gain %s gold.",
                    results: [{ name: "LvlGold", value: 0.2 }]
                  }]
    },
    choice_3: {
        action: "Ignore Them",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }]
                  }]
    }
)

Encounter.where(
    message: "Stephen leans against a tree."
).first_or_create(
    short_name: "Stephen",
    skip_on_flags: Player.flag_mapping["flags"][:stephen_bucket],
    flags_required: Player.flag_mapping["flags"][:angry_stephen],
    choice_1: {
        action: "Wave",
        effects: [{ chance: 25,
                    message: "He throws a bucket at your head.  You decide to keep it.",
                    results: [{ name: "Flag", value: Player.flag_mapping["flags"][:stephen_bucket] }, { name: "Trinket", value: "Bucket of Might" }]
                  },
                  { chance: 75,
                    message: "He groans and shakes his head.  You gain %s exp by learning how to be disappointed.",
                    results: [{ name: "LvlExp", value: 0.1 }]
                  }]
    },
    choice_2: {
        action: "Attack",
        effects: [
                  { chance: 35,
                    message: "He smacks you for %s damage.",
                    results: [{ name: "CurrentHP", value: -0.1 }]
                  },
                  { chance: 65,
                    message: "He drops something shiny to distract you - and runs.  You gain %s jewel.",
                    results: [{ name: "Jewels", value: 1 }]
                  }]
    },
    choice_3: {
        action: "Ignore Him",
        effects: [{ chance: 100,
                    message: "You don't have time for this.",
                    results: [{ name: "Hours", value: -1 }]
                  }]
    }
)
