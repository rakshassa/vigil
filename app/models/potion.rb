class Potion < ApplicationRecord
    scope :with_effect, ->(effect_name) {
        query = "select potions.* from potions, jsonb_to_recordset(potions.effects) as eff(name text) where eff.name='#{effect_name}'"
        find_by_sql(query)
    }

    has_many :player_potions, dependent: :destroy

    def consume(player)
        Rails.logger.info "Consuming Effects: #{effects}"

        effects.each do |effect|
            ename = effect["name"]
            evalue = effect["value"]
            player.update(hours: player.hours + evalue) if ename == "Hours"
            player.update(skills: player.maxskills) if ename == "RefillSkills" # doesn't use the value
        end
    end
end
