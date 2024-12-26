class FightsController < ApplicationController
  before_action :set_fight, except: %w[boss]
  before_action :set_fight_player

  def boss
    @fight = EncounterSelector.new.boss_fight(@player)
    Rails.logger.info "Created Boss Fight: #{@fight.id}"

    redirect_to wilderness_menus_path(@player, fight_id: @fight.id)
  end

  def run
    # return redirect_to wilderness_menus_path(@player, fight_id: @fight.id) if ((Time.now - @fight.updated_at).in_milliseconds < 500)
    return redirect_to dash_menus_path, notice: "Running from an ended fight." if @fight.ended

    CombatResolver.new(@fight).run
    redirect_to wilderness_menus_path(@player, fight_id: @fight.id)
  end

  def attack
    # return redirect_to wilderness_menus_path(@player, fight_id: @fight.id) if ((Time.now - @fight.updated_at).in_milliseconds < 500)
    return redirect_to dash_menus_path, notice: "Attacking from an ended fight." if @fight.ended

    CombatResolver.new(@fight).attack
    redirect_to wilderness_menus_path(@player, fight_id: @fight.id)
  end

  def backstab
    # return redirect_to wilderness_menus_path(@player, fight_id: @fight.id) if ((Time.now - @fight.updated_at).in_milliseconds < 500)
    return redirect_to dash_menus_path, notice: "Skill from an ended fight." if @fight.ended

    CombatResolver.new(@fight).backstab
    redirect_to wilderness_menus_path(@player, fight_id: @fight.id)
  end

  private

  def set_fight_player
    @player = Player.find(params[:player_id])
  end

  def set_fight
    @fight = Fight.find(params[:id])
  end
end
