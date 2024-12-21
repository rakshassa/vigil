class MenusController < ApplicationController
  before_action :set_player
  before_action :ensure_no_fight, except: %i[wilderness]

  def dash
  end

  def wilderness
    if params[:fight_id].present?
      # continue the fight
      @fight = Fight.find(params[:fight_id])
    else
      # start a new fight
      @fight = EncounterSelector.new.select(@player)
    end
  end

  private

  def set_player
    playerid = params[:id]
    playerid = Player.first.id if playerid.nil?

    @player = Player.find(playerid)
  end

  def ensure_no_fight
    record = Fight.where(player_id: @player).first
    return if record.nil?

    redirect_to wilderness_menus_path(fight_id: record.id), notice: 'Your attempt to cheat has been logged. Do not continue. You have been warned.'
  end
end
