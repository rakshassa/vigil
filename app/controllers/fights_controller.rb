class FightsController < ApplicationController
  before_action :set_fight

  def run
    CombatResolver.new(@fight).run
    redirect_to wilderness_menus_path(fight_id: @fight.id)
  end

  def attack
    CombatResolver.new(@fight).attack
    redirect_to wilderness_menus_path(fight_id: @fight.id)
  end

  def backstab
    CombatResolver.new(@fight).backstab
    redirect_to wilderness_menus_path(fight_id: @fight.id)
  end

  private

  def set_fight
    # TODO: ensure this player has access to this fight once we have authentication
    @fight = Fight.find(params[:id])
  end
end
