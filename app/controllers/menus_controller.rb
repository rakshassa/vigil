class MenusController < ApplicationController
  before_action :set_player, except: %i[login start_game]
  before_action :ensure_no_fight, except: %i[wilderness]
  before_action :default_disables


  def healer
  end

  def heal
    @player.heal
    redirect_to dash_menus_path(@player, message: 'You heal as much as you can afford.')
  end

  def trainer
  end

  def shop
  end

  def login
  end

  def start_game
    Player.destroy_all

    record = Player.create(
      level_id: Level.first.id, maxhp: 10, currenthp: 10, gold: 0, gems: 0, baseatk: 5, basedef: 1,
      skills: 1, weapon_id: Weapon.first.id, armor_id: Armor.first.id, days: 0, hours: 0, exp: 0
    )
    redirect_to dash_menus_path(id: record.id)
  end

  def dash
    @message = params[:message]
    @message = "Welcome to Vigil.<br><br>What would you like to do?" if @message.blank?
  end

  def wilderness
    Rails.logger.info "Params in wilderness: #{params}"
    records = Fight.where(player_id: @player.id, ended: false)
    raise ActionController::BadRequest.new(), "More than one ongoing fight." if records.count > 1

    fight_id = params[:fight_id]&.to_i

    # if the input param was lost/removed, just use the only available fight
    # fight_id = records.first.id if fight_id.blank? && records.count == 1
    raise ActionController::BadRequest.new(), "Wrong Fight ID" if records.count == 1 && records.first.id != fight_id

    if fight_id.present?
      Rails.logger.info "Continuing Fight #{fight_id}"
      @fight = Fight.find(fight_id)
    else
      # start a new fight
      @fight = EncounterSelector.new.select(@player)
      Rails.logger.info "Created Fight: #{@fight.id}"
    end

    @disable_actions = @player.is_dead? || !@fight.ended
  end

  private

  def default_disables
    @disable_actions = false
  end

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
end
