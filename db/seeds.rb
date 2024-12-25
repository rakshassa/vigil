# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Armor.where(name: 'Robe', cost: '10', defense: '2').first_or_create
Armor.where(name: 'Leather Armor', cost: '100', defense: '4').first_or_create
Armor.where(name: 'Chain Mail', cost: '500', defense: '7').first_or_create
Armor.where(name: 'Scale Mail', cost: '2000', defense: '12').first_or_create
Armor.where(name: 'Plate Mail', cost: '10000', defense: '20').first_or_create

Weapon.where(name: 'Stick', cost: '10', mindmg: 1, maxdmg: 3).first_or_create
Weapon.where(name: 'Dagger', cost: '100', mindmg: 2, maxdmg: 5).first_or_create
Weapon.where(name: 'Short Sword', cost: '500', mindmg: 4, maxdmg: 10).first_or_create
Weapon.where(name: 'Broad Sword', cost: '2000', mindmg: 7, maxdmg: 25).first_or_create
Weapon.where(name: 'Great Sword', cost: '10000', mindmg: 15, maxdmg: 50).first_or_create

Monster.where(name: 'Crazed Midget', level: 1, strength: 2, exp: 2, hp: 5, gold: 6, weapon: 'nails you with a Nut Punch', death: 'He crumples to the ground.  ').first_or_create
Monster.where(name: 'Honey Badger', level: 1, strength: 3, exp: 1, hp: 4, gold: 17, weapon: 'scratches at you with his Pointy Toes', death: 'It screeches to a halt.  ').first_or_create
Monster.where(name: 'Large Mosquito', level: 1, strength: 4, exp: 3, hp: 6, gold: 12, weapon: 'drinks blood from your veins', death: 'It drifts to the ground.  ').first_or_create
Monster.where(name: 'Will o the Wisp', level: 1, strength: 5, exp: 6, hp: 8, gold: 25, weapon: 'drains your energy', death: 'It disperses into dust.  ').first_or_create
Monster.where(name: 'Shambling Skeleton', level: 1, strength: 6, exp: 7, hp: 9, gold: 21, weapon: 'pummels you with his Boney Fists', death: 'It tumbles into a pile of bones.  ').first_or_create
Monster.where(name: 'Goblin Ramsey', level: 1, strength: 7, exp: 10, hp: 14, gold: 30, weapon: 'smacks you with his Frying Pan', death: 'He grumbles as he collapses.  ').first_or_create

Monster.where(is_boss: true, name: 'Hungry Hippo', level: 1, strength: 10, exp: 15, hp: 22, gold: 40, weapon: 'bites you', death: 'It squelches into the mud.').first_or_create
Monster.where(is_boss: true, name: 'Ravenous Wildebeast', level: 1, strength: 12, exp: 15, hp: 12, gold: 40, weapon: 'impales you with his horns', death: 'It bleeds out.').first_or_create
Monster.where(is_boss: true, name: 'Mudman', level: 1, strength: 8, exp: 15, hp: 35, gold: 40, weapon: 'slaps you across the face', death: 'It disolves into the ground.').first_or_create

Monster.where(name: 'Billy Goat', level: 2, strength: 6, exp: 13, hp: 12, gold: 20, weapon: 'headbutts you', death: 'It Quivers until lifeless.  ').first_or_create
Monster.where(name: 'Goblin Warrior', level: 2, strength: 7, exp: 15, hp: 19, gold: 32, weapon: 'sticks you with a pointy branch', death: 'He falls on his face.  ').first_or_create
Monster.where(name: 'Animated Spear', level: 2, strength: 9, exp: 17, hp: 15, gold: 55, weapon: 'stabs you in the thigh', death: 'It falls to the floor.  ').first_or_create
Monster.where(name: 'Stirge', level: 2, strength: 11, exp: 19, hp: 26, gold: 42, weapon: 'drinks your blood', death: 'His humming stops.  ').first_or_create
Monster.where(name: 'Spiteful Imp', level: 2, strength: 12, exp: 21, hp: 18, gold: 35, weapon: 'burns you with his palm', death: 'Its corpse melds into the earth.  ').first_or_create
Monster.where(name: 'Mangy Beaver', level: 2, strength: 13, exp: 23, hp: 27, gold: 61, weapon: 'gnaws on your leg', death: 'Its corpse rolls away from you.  ').first_or_create

Monster.where(is_boss: true, name: 'Shambling Zombie', level: 2, strength: 13, exp: 37, hp: 52, gold: 80, weapon: 'scratches you with his filthy nails', death: 'It falls into pieces.').first_or_create
Monster.where(is_boss: true, name: 'White Ape', level: 2, strength: 15, exp: 40, hp: 50, gold: 100, weapon: 'smashes you with his fists', death: 'It howls with its last breath.').first_or_create
Monster.where(is_boss: true, name: 'Viper', level: 2, strength: 17, exp: 42, hp: 26, gold: 90, weapon: 'sinks his fangs deep into your leg', death: 'It lays still.').first_or_create

Monster.where(name: 'Tiny Dancer', level: 3, strength: 12, exp: 20, hp: 12, gold: 46, weapon: 'headbutts you', death: 'It Quivers until lifeless.  ').first_or_create
Monster.where(name: 'Whirling Dervish', level: 3, strength: 14, exp: 25, hp: 19, gold: 32, weapon: 'sticks you with a pointy branch', death: 'He falls on his face.  ').first_or_create
Monster.where(name: 'Swarm of Mites', level: 3, strength: 16, exp: 27, hp: 15, gold: 41, weapon: 'stabs you in the thigh', death: 'It falls to the floor.  ').first_or_create
Monster.where(name: 'Crackling Cloud', level: 3, strength: 18, exp: 39, hp: 26, gold: 62, weapon: 'drinks your blood', death: 'His humming stops.  ').first_or_create
Monster.where(name: 'Speckled Serpent', level: 3, strength: 21, exp: 21, hp: 18, gold: 105, weapon: 'burns you with his palm', death: 'Its corpse melds into the earth.  ').first_or_create
Monster.where(name: 'Derek', level: 3, strength: 25, exp: 23, hp: 43, gold: 81, weapon: 'gnaws on your leg', death: 'Its corpse rolls away from you.  ').first_or_create

Monster.where(is_boss: true, name: 'JT the Airman', level: 3, strength: 20, exp: 55, hp: 72, gold: 130, weapon: 'beats you down with his sarcasm', death: 'He seems confused as he falls over.').first_or_create
Monster.where(is_boss: true, name: 'Very Large Bat', level: 3, strength: 25, exp: 70, hp: 80, gold: 120, weapon: 'rips at your eyes', death: 'It skids across the ground.').first_or_create
Monster.where(is_boss: true, name: 'Angry Clown', level: 3, strength: 30, exp: 82, hp: 56, gold: 140, weapon: 'tells a really bad joke', death: 'Its rubber nose bounces away.').first_or_create

Level.where(id: 1, hp: 10, atk: 5, def: 2, name: '1', exp: 0, gold: 0).first_or_create
Level.where(id: 2, hp: 10, atk: 3, def: 2, name: '2', exp: 50, gold: 100).first_or_create
Level.where(id: 3, hp: 25, atk: 5, def: 4, name: '3', exp: 250, gold: 300).first_or_create
Level.where(id: 4, hp: 35, atk: 7, def: 6, name: '4', exp: 1000, gold: 1000).first_or_create
Level.where(id: 5, hp: 50, atk: 9, def: 8, name: '5', exp: 5000, gold: 3000).first_or_create
Level.where(id: 6, hp: 75, atk: 12, def: 11, name: '6', exp: 20000, gold: 10000).first_or_create
Level.where(id: 7, hp: 100, atk: 16, def: 15, name: '7', exp: 150000, gold: 30000).first_or_create
Level.where(id: 8, hp: 200, atk: 22, def: 20, name: 'MAX', exp: 500000, gold: 100000).first_or_create

Setting.where(name: 'gold_variance', value: 0.25).first_or_create
Setting.where(name: 'exp_variance', value: 0.25).first_or_create
Setting.where(name: 'monster_dmg_variance', value: 0.25).first_or_create
Setting.where(name: 'player_hit_percentage', value: 90).first_or_create
Setting.where(name: 'monster_hit_percentage', value: 70).first_or_create
Setting.where(name: 'player_run_percentage', value: 80).first_or_create
Setting.where(name: 'player_crit_chance_percentage', value: 10).first_or_create
Setting.where(name: 'player_crit_dmg_multiplier', value: 2.0).first_or_create
Setting.where(name: 'skill_dmg_multiplier', value: 3.0).first_or_create
Setting.where(name: 'heal_cost_per_hp').first_or_create(value: 5)
Setting.where(name: 'daily_hours').first_or_create(value: 24)
Setting.where(name: 'weekly_days').first_or_create(value: 7)

Trinket.where(name: "Precision", desc: "You miss half as often.", cost: 100, effects: { name: "Miss", value: 0.5 }.to_json).first_or_create
