Trinket.where(name: "Precision").first_or_create(desc: "You miss half as often.", cost: 2, icon: "bi-bullseye", effects: [{ name: "Miss_Perc", value: 0.5 }])
Trinket.where(name: "Forged").first_or_create(desc: "Increase attack by 2.", cost: 1, icon: "bi-hammer", effects: [{ name: "Attack", value: 2 }])
Trinket.where(name: "Shield").first_or_create(desc: "Increase defense by 2.", cost: 1, icon: "bi-shield-fill-plus", effects: [{ name: "Defense", value: 2 }])
Trinket.where(name: "Health").first_or_create(desc: "Increase max HP by 5.", cost: 1, icon: "bi-capsule", effects: [{ name: "MaxHP", value: 5 }])
Trinket.where(name: "Herbalist").first_or_create(desc: "The first 5 HP of healing is free.", cost: 3, icon: "bi-clipboard-heart", effects: [{ name: "HealFree", value: 5 }])
Trinket.where(name: "Friendship").first_or_create(desc: "Healing cost is reduced by 1 per HP.", cost: 2, icon: "bi-clipboard-heart-fill", effects: [{ name: "HealPrice", value: -1 }])
Trinket.where(name: "Sneaky").first_or_create(desc: "You never fail to run away.", cost: 3, icon: "bi-incognito", effects: [{ name: "RunChance", value: 100 }])
Trinket.where(name: "Loaded").first_or_create(desc: "You loot more gold (10%).", cost: 2, icon: "bi-minecart-loaded", effects: [{ name: "GoldLoot", value: 0.1 }])
Trinket.where(name: "Fast Learner").first_or_create(desc: "You gain more exp (10%).", cost: 2, icon: "bi-mortarboard", effects: [{ name: "ExpLoot", value: 0.1 }])
Trinket.where(name: "Bargain").first_or_create(desc: "Weapons and Armor cost less (20%).", cost: 4, icon: "bi-shop", effects: [{ name: "ShopDiscount", value: 0.2 }])
Trinket.where(name: "Traps").first_or_create(desc: "Bosses start with 10 damage taken.", cost: 3, icon: "bi-house-check", effects: [{ name: "BossHP", value: -10 }])
Trinket.where(name: "Walls").first_or_create(desc: "Bosses miss twice as often.", cost: 4, icon: "bi-shield-shaded", effects: [{ name: "BossMiss", value: 2 }])
Trinket.where(name: "Trained").first_or_create(desc: "You do not need to train after buying armor or weapons.", cost: 2, icon: "bi-heart-arrow", effects: [{ name: "ShopAction", value: -1 }])
Trinket.where(name: "Mail Order").first_or_create(desc: "You do not need to wait after buying jewelry.", cost: 2, icon: "bi-envelope-open-heart", effects: [{ name: "JewelryAction", value: -1 }])
Trinket.where(name: "Inventory").first_or_create(desc: "Jeweler sells one more item each day.", cost: 3, icon: "bi-tag", effects: [{ name: "JewelryMax", value: 1 }])
Trinket.where(name: "Mesmerize").first_or_create(desc: "Use skills one extra time per day.", cost: 3, icon: "bi-hypnotize", effects: [{ name: "MaxSkills", value: 1 }])
Trinket.where(name: "Scavenger").first_or_create(desc: "Find gems more often (15%).", cost: 5, icon: "bi-piggy-bank", effects: [{ name: "GemFind", value: 15 }])
Trinket.where(name: "Puncture").first_or_create(desc: "You critically strike more often (10%).", cost: 2, icon: "bi-scissors", effects: [{ name: "CritChance", value: 10 }])
Trinket.where(name: "Twist").first_or_create(desc: "Inflict more damage when critically striking (50%).", cost: 2, icon: "bi-lightning", effects: [{ name: "CritDmg", value: 0.5 }])
Trinket.where(name: "Tactics").first_or_create(desc: "Skills do more damage, but critical hits do less.", cost: 1, icon: "bi-yin-yang", effects: [{ name: "CritDmg", value: -0.5 }, { name: "SkillDmg", value: 0.5 }])
Trinket.where(name: "Spyglass").first_or_create(desc: "You can see farther in the wilderness.", cost: 2, icon: "bi-eyeglasses", effects: [{ name: "Roads", value: 1 }])

# Reserved Trinkets
Trinket.where(name: "Squirrel").first_or_create(desc: "The jewelers favorite animal.", cost: 1, icon: "bi-bug", effects: [{ name: "JewelryMax", value: 1 }], reserved: true)
Trinket.where(name: "Ring of Speed").first_or_create(desc: "Your days are 2 hours longer.", cost: 5, icon: "bi-speedometer", effects: [{ name: "daily_hours", value: 2 }], reserved: true)
Trinket.where(name: "Bucket of Might").first_or_create(desc: "You gain 3 strength and 3 defense.", cost: 5, icon: "bi-bucket", effects: [{ name: "Attack", value: 3 }, { name: "Defense", value: 3 }], reserved: true)
