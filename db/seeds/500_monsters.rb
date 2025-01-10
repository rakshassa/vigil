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
