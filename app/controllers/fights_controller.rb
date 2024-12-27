class FightsController < ApplicationController
  before_action :set_fight, except: %w[boss]
  before_action :set_fight_player

  def boss
    @fight = EncounterSelector.new.boss_fight(@player)
    Rails.logger.info "Created Boss Fight: #{@fight.id}"

    redirect_to wilderness_menus_path(player_id: @player.id, fight_id: @fight.id)
  end

  def run
    return redirect_to dash_menus_path(player_id: @player.id), notice: "Running from an ended fight." if @fight.ended

    CombatResolver.new(@fight).run
    redirect_to wilderness_menus_path(player_id: @player.id, fight_id: @fight.id)
  end

  def attack
    return redirect_to dash_menus_path(player_id: @player.id), notice: "Attacking from an ended fight." if @fight.ended

    CombatResolver.new(@fight).attack
    redirect_to wilderness_menus_path(player_id: @player.id, fight_id: @fight.id)
  end

  def backstab
    return redirect_to dash_menus_path(player_id: @player.id), notice: "Skill from an ended fight." if @fight.ended

    CombatResolver.new(@fight).backstab
    redirect_to wilderness_menus_path(player_id: @player.id, fight_id: @fight.id)
  end

  private

  def set_fight_player
    @player = Player.find(params[:player_id])
  end

  def set_fight
    @fight = Fight.find(params[:fight_id])
  end
end
