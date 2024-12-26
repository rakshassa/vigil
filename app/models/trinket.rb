class Trinket < ApplicationRecord
    scope :not_owned, ->(player_id) {
        owned = PlayerTrinket.where(player_id: player_id, bought: true).select(:trinket_id)

        where.not(id: owned)
    }
    has_many :player_trinkets, dependent: :destroy

    def on_obtain(player)
        Rails.logger.info "Obtaining Effects: #{effects}"
        effects.each do |effect|
            ename = effect["name"]
            evalue = effect["value"]
            player.update(maxhp: player.maxhp + evalue, currenthp: player.currenthp + evalue) if ename == "MaxHP"
            player.update(basedef: player.basedef + evalue) if ename == "Defense"
            player.update(baseatk: player.baseatk + evalue) if ename == "Attack"
            player.update(baseskills: player.baseskills + evalue, skills: player.skills + evalue) if ename == "MaxSkills"
        end
    end

    def on_discard(player)
        effects.each do |effect|
            ename = effect["name"]
            evalue = effect["value"]
            player.update(maxhp: player.maxhp - evalue, currenthp: [player.currenthp, player.maxhp - evalue].min) if ename == "MaxHP"
            player.update(basedef: player.basedef - evalue) if ename == "Defense"
            player.update(baseatk: player.baseatk - evalue) if ename == "Attack"
            player.update(baseskills: player.baseskills - evalue, skills: [player.skills, player.baseskills - evalue].min) if ename == "MaxSkills"
        end
    end
end
