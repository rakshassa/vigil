# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Armor.where(name: "Robe", cost: "10", defense: "2").first_or_create
Armor.where(name: "Leather Armor", cost: "100", defense: "4").first_or_create
Armor.where(name: "Chain Mail", cost: "500", defense: "7").first_or_create
Armor.where(name: "Scale Mail", cost: "2000", defense: "12").first_or_create
Armor.where(name: "Plate Mail", cost: "10000", defense: "20").first_or_create
Armor.where(name: "Bronze Mail", cost: "30000", defense: "35").first_or_create

Weapon.where(name: "Stick", cost: "10", mindmg: 1, maxdmg: 3).first_or_create
Weapon.where(name: "Dagger", cost: "100", mindmg: 2, maxdmg: 5).first_or_create
Weapon.where(name: "Short Sword", cost: "500", mindmg: 4, maxdmg: 10).first_or_create
Weapon.where(name: "Falchion", cost: "2000", mindmg: 7, maxdmg: 25).first_or_create
Weapon.where(name: "Broad Sword", cost: "10000", mindmg: 15, maxdmg: 50).first_or_create
Weapon.where(name: "Great Sword", cost: "10000", mindmg: 25, maxdmg: 100).first_or_create

Monster.where(name: "Crazed Midget", level: 1, strength: 4, exp: 2, hp: 5, gold: 6, weapon: "nails you with a Nut Punch", death: "He crumples to the ground.  ").first_or_create
Monster.where(name: "Honey Badger", level: 1, strength: 3, exp: 1, hp: 4, gold: 17, weapon: "scratches at you with his Pointy Toes", death: "It screeches to a halt.  ").first_or_create
Monster.where(name: "Large Mosquito", level: 1, strength: 4, exp: 3, hp: 6, gold: 12, weapon: "drinks blood from your veins", death: "It drifts to the ground.  ").first_or_create
Monster.where(name: "Will o the Wisp", level: 1, strength: 5, exp: 6, hp: 8, gold: 25, weapon: "drains your energy", death: "It disperses into dust.  ").first_or_create
Monster.where(name: "Shambling Skeleton", level: 1, strength: 6, exp: 7, hp: 9, gold: 21, weapon: "pummels you with his Boney Fists", death: "It tumbles into a pile of bones.  ").first_or_create
Monster.where(name: "Goblin Ramsey", level: 1, strength: 7, exp: 10, hp: 14, gold: 30, weapon: "smacks you with his Frying Pan", death: "He grumbles as he collapses.  ").first_or_create

Monster.where(is_boss: true, name: "Hungry Hippo", level: 1, strength: 10, exp: 15, hp: 22, gold: 40, weapon: "bites you", death: "It squelches into the mud.").first_or_create
Monster.where(is_boss: true, name: "Ravenous Wildebeast", level: 1, strength: 13, exp: 15, hp: 12, gold: 40, weapon: "impales you with his horns", death: "It bleeds out.").first_or_create
Monster.where(is_boss: true, name: "Mudman", level: 1, strength: 11, exp: 15, hp: 35, gold: 40, weapon: "slaps you across the face", death: "It disolves into the ground.").first_or_create

Monster.where(name: "Billy Goat", level: 2, strength: 6, exp: 13, hp: 12, gold: 20, weapon: "headbutts you", death: "It Quivers until lifeless.  ").first_or_create
Monster.where(name: "Goblin Warrior", level: 2, strength: 7, exp: 15, hp: 19, gold: 32, weapon: "sticks you with a pointy branch", death: "He falls on his face.  ").first_or_create
Monster.where(name: "Animated Spear", level: 2, strength: 14, exp: 17, hp: 15, gold: 55, weapon: "stabs you in the thigh", death: "It falls to the floor.  ").first_or_create
Monster.where(name: "Stirge", level: 2, strength: 11, exp: 19, hp: 26, gold: 42, weapon: "drinks your blood", death: "His humming stops.  ").first_or_create
Monster.where(name: "Spiteful Imp", level: 2, strength: 15, exp: 21, hp: 18, gold: 35, weapon: "burns you with his palm", death: "Its corpse melds into the earth.  ").first_or_create
Monster.where(name: "Mangy Beaver", level: 2, strength: 17, exp: 23, hp: 27, gold: 61, weapon: "gnaws on your leg", death: "Its corpse rolls away from you.  ").first_or_create

Monster.where(is_boss: true, name: "Shambling Zombie", level: 2, strength: 20, exp: 37, hp: 52, gold: 80, weapon: "scratches you with his filthy nails", death: "It falls into pieces.").first_or_create
Monster.where(is_boss: true, name: "White Ape", level: 2, strength: 18, exp: 40, hp: 50, gold: 100, weapon: "smashes you with his fists", death: "It howls with its last breath.").first_or_create
Monster.where(is_boss: true, name: "Viper", level: 2, strength: 22, exp: 42, hp: 26, gold: 90, weapon: "sinks his fangs deep into your leg", death: "It lays still.").first_or_create

Monster.where(name: "Tiny Dancer", level: 3, strength: 18, exp: 20, hp: 22, gold: 46, weapon: "headbutts you", death: "It Quivers until lifeless.  ").first_or_create
Monster.where(name: "Whirling Dervish", level: 3, strength: 17, exp: 25, hp: 29, gold: 32, weapon: "sticks you with a pointy branch", death: "He falls on his face.  ").first_or_create
Monster.where(name: "Swarm of Mites", level: 3, strength: 16, exp: 27, hp: 25, gold: 41, weapon: "stabs you in the thigh", death: "It falls to the floor.  ").first_or_create
Monster.where(name: "Crackling Cloud", level: 3, strength: 23, exp: 39, hp: 26, gold: 62, weapon: "drinks your blood", death: "His humming stops.  ").first_or_create
Monster.where(name: "Speckled Serpent", level: 3, strength: 21, exp: 21, hp: 38, gold: 105, weapon: "burns you with his palm", death: "Its corpse melds into the earth.  ").first_or_create
Monster.where(name: "Derek", level: 3, strength: 25, exp: 25, hp: 43, gold: 81, weapon: "gnaws on your leg", death: "Its corpse rolls away from you.  ").first_or_create

Monster.where(is_boss: true, name: "JT the Airman", level: 3, strength: 30, exp: 55, hp: 72, gold: 130, weapon: "beats you down with his sarcasm", death: "He seems confused as he falls over.").first_or_create
Monster.where(is_boss: true, name: "Very Large Bat", level: 3, strength: 25, exp: 70, hp: 80, gold: 120, weapon: "rips at your eyes", death: "It skids across the ground.").first_or_create
Monster.where(is_boss: true, name: "Angry Clown", level: 3, strength: 35, exp: 82, hp: 56, gold: 140, weapon: "tells a really bad joke", death: "Its rubber nose bounces away.").first_or_create

Monster.where(name: "Rhino", level: 4, strength: 25, exp: 55, hp: 42, gold: 66, weapon: "headbutts you", death: "It slides into a tree.  ").first_or_create
Monster.where(name: "Dust Storm", level: 4, strength: 28, exp: 68, hp: 45, gold: 72, weapon: "grinds your flesh", death: "It slowly stops spinning.  ").first_or_create
Monster.where(name: "Purple Worm", level: 4, strength: 34, exp: 70, hp: 75, gold: 41, weapon: "bites deep into your leg", death: "It flops down, lifeless.  ").first_or_create
Monster.where(name: "JT the Pally", level: 4, strength: 26, exp: 53, hp: 56, gold: 112, weapon: "slaps you across the face", death: "His spirit storms off.  ").first_or_create
Monster.where(name: "Giant Hawk", level: 4, strength: 35, exp: 80, hp: 58, gold: 75, weapon: "pecks at yoru face", death: "It no longer caws into the night.  ").first_or_create
Monster.where(name: "Gelatinous Cube", level: 4, strength: 41, exp: 85, hp: 63, gold: 121, weapon: "melts your skin", death: "It melts into the dirt.  ").first_or_create

Monster.where(is_boss: true, name: "Esteban", level: 4, strength: 45, exp: 155, hp: 102, gold: 230, weapon: "groans at you in disappointment", death: "He smiles as he collapses.").first_or_create
Monster.where(is_boss: true, name: "Small Dragon", level: 4, strength: 40, exp: 170, hp: 120, gold: 220, weapon: "breaths acid at you", death: "It chokes on its own blood.").first_or_create
Monster.where(is_boss: true, name: "Sock Puppet", level: 4, strength: 50, exp: 182, hp: 86, gold: 240, weapon: "hits you with his crusty toes", death: "It snaps in two.").first_or_create

Level.where(id: 1, hp: 10, atk: 5, def: 2, name: "1", exp: 0, gold: 0).first_or_create
Level.where(id: 2, hp: 10, atk: 3, def: 2, name: "2", exp: 50, gold: 100).first_or_create
Level.where(id: 3, hp: 25, atk: 5, def: 4, name: "3", exp: 250, gold: 300).first_or_create
Level.where(id: 4, hp: 35, atk: 7, def: 6, name: "4", exp: 1000, gold: 1000).first_or_create
Level.where(id: 5, hp: 50, atk: 9, def: 8, name: "5", exp: 5000, gold: 3000).first_or_create
Level.where(id: 6, hp: 75, atk: 12, def: 11, name: "6", exp: 20000, gold: 10000).first_or_create
Level.where(id: 7, hp: 100, atk: 16, def: 15, name: "7", exp: 150000, gold: 30000).first_or_create
Level.where(id: 8, hp: 200, atk: 22, def: 20, name: "MAX", exp: 500000, gold: 100000).first_or_create

Setting.where(name: "gold_variance", value: 0.25).first_or_create
Setting.where(name: "exp_variance", value: 0.25).first_or_create
Setting.where(name: "monster_dmg_variance", value: 0.25).first_or_create
Setting.where(name: "player_hit_percentage", value: 90).first_or_create
Setting.where(name: "monster_hit_percentage", value: 70).first_or_create
Setting.where(name: "player_run_percentage", value: 80).first_or_create
Setting.where(name: "player_crit_chance_percentage", value: 10).first_or_create
Setting.where(name: "player_crit_dmg_multiplier", value: 2.0).first_or_create
Setting.where(name: "skill_dmg_multiplier", value: 3.0).first_or_create
Setting.where(name: "heal_cost_per_hp").first_or_create(value: 5)
Setting.where(name: "daily_hours").first_or_create(value: 24)
Setting.where(name: "weekly_days").first_or_create(value: 7)
Setting.where(name: "gem_chance_percentage").first_or_create(value: 25)
Setting.where(name: "jeweler_inventory").first_or_create(value: 3)
Setting.where(name: "alchemist_inventory").first_or_create(value: 3)
Setting.where(name: "boss_prizes").first_or_create(value: 3)

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

Potion.where(name: "Protein").first_or_create(desc: "Your next attack will critically hit", cost: 1, icon: "bi-egg", effects: [{ name: "AutoCrit", value: 100 }], immediate: false)
Potion.where(name: "Blind").first_or_create(desc: "Your enemy will miss its next attack.", cost: 1, icon: "bi-eye-slash", effects: [{ name: "EnemyMiss", value: 1.0 }], immediate: false)
Potion.where(name: "Chronos").first_or_create(desc: "Turn the clock back 3 hours.", cost: 1, icon: "bi-clock", effects: [{ name: "Hours", value: -3 }], immediate: true)
Potion.where(name: "Recharge").first_or_create(desc: "All of your skill points are refilled.", cost: 1, icon: "bi-clock-history", effects: [{ name: "RefillSkills", value: 100 }], immediate: true)
Potion.where(name: "Midas").first_or_create(desc: "Increase your gold (10%).", cost: 1, icon: "bi-credit-card", effects: [{ name: "MoreGold", value: 10 }], immediate: true)
Potion.where(name: "Rest").first_or_create(desc: "Heal all HP.", cost: 2, icon: "bi-cloud-moon", effects: [{ name: "FullHeal", value: 100 }], immediate: true)
Potion.where(name: "Quench").first_or_create(desc: "The Bard can sing again today.", cost: 2, icon: "bi-droplet", effects: [{ name: "BardSong", value: 100 }], immediate: true)

# icons: clock-fill
# cloud-drizzle, cloud-sun
# emoji-laughing, eye, flower1
# hourglass-bottom,
# peace, shop, umbrella
