class FightsController < ApplicationController
  before_action :set_fight

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

  def set_fight
    @player = Player.find(params[:player_id])
    @fight = Fight.find(params[:id])
  end
end
