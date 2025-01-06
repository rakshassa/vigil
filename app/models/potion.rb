class Potion < ApplicationRecord
    scope :with_effect, ->(effect_name) {
        query = "select potions.* from potions, jsonb_to_recordset(potions.effects) as eff(name text) where eff.name=?"
        find_by_sql([query, effect_name])
    }

    has_many :player_potions, dependent: :destroy

    def consume(player)
        Rails.logger.info "Consuming Effects: #{effects}"

        effects.each do |effect|
            ename = effect["name"]
            evalue = effect["value"]

            player.update(hours: player.hours + evalue) if ename == "Hours"
            player.update(skills: player.baseskills) if ename == "RefillSkills" # doesn't use the value
            player.update(gold: player.gold * 1.1) if ename == "MoreGold"
            player.update(currenthp: player.maxhp) if ename == "FullHeal"
            player.update(used_bard: false) if ename == "BardSong"
        end
    end
end
