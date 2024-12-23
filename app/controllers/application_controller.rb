class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def set_player
    playerid = params[:id]
    playerid = Player.first.id if playerid.nil?

    @player = Player.find(playerid)
  end

  def ensure_no_fight
    record = Fight.where(player_id: @player, ended: false).first
    return if record.nil?

    redirect_to wilderness_menus_path(fight_id: record.id), notice: 'Your attempt to cheat has been logged. Do not continue. You have been warned.'
  end

  def default_disables
    @disable_actions = false
  end
end
