Level.where(id: 1, hp: 10, atk: 5, def: 2, name: "1", exp: 0, gold: 0).first_or_create
Level.where(id: 2, hp: 10, atk: 3, def: 2, name: "2", exp: 50, gold: 100).first_or_create
Level.where(id: 3, hp: 25, atk: 5, def: 4, name: "3", exp: 250, gold: 300).first_or_create
Level.where(id: 4, hp: 35, atk: 7, def: 6, name: "4", exp: 1000, gold: 1000).first_or_create
Level.where(id: 5, hp: 50, atk: 9, def: 8, name: "5", exp: 5000, gold: 3000).first_or_create
Level.where(id: 6, hp: 75, atk: 12, def: 11, name: "6", exp: 20000, gold: 10000).first_or_create
Level.where(id: 7, hp: 100, atk: 16, def: 15, name: "7", exp: 150000, gold: 30000).first_or_create
Level.where(id: 8, hp: 200, atk: 22, def: 20, name: "MAX", exp: 500000, gold: 100000).first_or_create
