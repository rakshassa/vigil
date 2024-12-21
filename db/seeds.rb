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
Armor.where(name: 'Leather Armor', cost: '100', defense: '5').first_or_create
Armor.where(name: 'Chain Mail', cost: '500', defense: '10').first_or_create
Armor.where(name: 'Scale Mail', cost: '2000', defense: '20').first_or_create
Armor.where(name: 'Plate Mail', cost: '10000', defense: '50').first_or_create

Weapon.where(name: 'Stick', cost: '10', mindmg: 1, maxdmg: 3).first_or_create
Weapon.where(name: 'Dagger', cost: '100', mindmg: 2, maxdmg: 5).first_or_create
Weapon.where(name: 'Short Sword', cost: '500', mindmg: 4, maxdmg: 10).first_or_create
Weapon.where(name: 'Broad Sword', cost: '2000', mindmg: 7, maxdmg: 25).first_or_create
Weapon.where(name: 'Great Sword', cost: '10000', mindmg: 15, maxdmg: 50).first_or_create

if Player.count.zero?
    Player.create(
      level: 1, maxhp: 10, currenthp: 10, gold: 0, gems: 0, baseatk: 5, basedef: 1,
      skills: 1, weapon_id: Weapon.first.id, armor_id: Armor.first.id, days: 0, hours: 0, exp: 0
    )
end

Monster.where(name: 'Crazed Midget', level: 1, strength: 2, exp: 2, hp: 5, gold: 46, weapon: 'nails you with a Nut Punch', death: 'He crumples to the ground.  ').first_or_create
Monster.where(name: 'Honey Badger', level: 1, strength: 3, exp: 1, hp: 4, gold: 32, weapon: 'scratches at you with his Pointy Toes', death: 'It screeches to a halt.  ').first_or_create
Monster.where(name: 'Shambling Skeleton', level: 1, strength: 6, exp: 2, hp: 9, gold: 56, weapon: 'pummels you with his Boney Fists', death: 'It tumbles into a pile of bones.  ').first_or_create
