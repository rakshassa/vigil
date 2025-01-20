class MenusController < ApplicationController
  before_action :set_player, except: %i[login start_game]
  # before_action :ensure_no_fight, except: %i[wilderness]
  before_action :default_disables

  def bard
  end

  def bard_buff
    return redirect_to dash_menus_path(player_id: @player.id, message: "Jaskier is too tired to perform again today.") if @player.used_bard

    message = @player.bard_buff
    redirect_to dash_menus_path(player_id: @player.id, message: message)
  end

  def healer
  end

  def heal
    @player.heal
    redirect_to dash_menus_path(player_id: @player.id, message: "You heal as much as you can afford.")
  end

  def training
  end

  def train
    return redirect_to dash_menus_path(player_id: @player.id, message: "You are not ready to train.") unless @player.can_level?
    return redirect_to dash_menus_path(player_id: @player.id, message: "You can't afford to train.") if @player.gold < @player.next_level.gold

    message = @player.level_up
    redirect_to dash_menus_path(player_id: @player.id, message: message)
  end

  def login
  end

  def start_game
    Player.destroy_all

    record = Player.make_new_thief

    redirect_to dash_menus_path(player_id: record.id)
  end

  def dash
    @day_ended = @player.day_ended?

    @message = params[:message].to_s
    @message += "<br>" unless @message.blank?
    if @day_ended
      @message += "A dangerous foe approaches."
      @disable_actions = true
    end

    @message = "Welcome to Vigil.<br><br>What would you like to do?" if @message.blank?
  end

  def road
    # display a few action choices
    @disable_actions = true
    @player.increment_hours
    EncounterSelector.new.select(@player) unless @player.roads.exists?
    @roads = Road.where(player_id: @player.id)
  end

  def select_road
    # find the selected road record
    road_id = params[:road_id]&.to_i
    road = Road.where(id: road_id, player_id: @player.id).first
    raise ActionController::BadRequest.new(), "Invalid Road Selection." if road.nil?

    fight = nil
    if road.monster_id.nil?
      encounter = road.encounter
      fight = Fight.create(player_id: @player.id, encounter_id: encounter.id, ended: false, message: encounter.message)
    else
      monster = road.monster
      start_msg = "The #{monster.name} is hostile."
      fight = Fight.create(player_id: @player.id, monster_id: monster.id, ended: false, currenthp: monster.hp, message: start_msg)
    end

    # clear road choices
    @player.roads.destroy_all

    # start the fight/encounter
    redirect_to wilderness_menus_path(player_id: @player.id, fight_id: fight.id)
  end

  def wilderness
    Rails.logger.info "Params in wilderness: #{params}"
    records = Fight.where(player_id: @player.id, ended: false)
    raise ActionController::BadRequest.new(), "More than one ongoing fight." if records.count > 1

    fight_id = params[:fight_id]&.to_i
    fight_id = records.first.id if fight_id.blank? && records.count == 1
    raise ActionController::BadRequest.new(), "Wrong Fight ID" if records.count == 1 && records.first.id != fight_id

    if fight_id.present?
      Rails.logger.info "Continuing Fight #{fight_id}"
      @fight = Fight.find(fight_id)
    else
      # start a new fight
      # @fight = EncounterSelector.new.select(@player)
      # @player.increment_hours # new encounter takes an hour
      # Rails.logger.info "Created Fight: #{@fight.id}"
      raise ActionController::BadRequest.new(), "Wilderness has no fight."
    end

    @day_ended = @player.day_ended?
    @disable_actions = @player.is_dead? || !@fight.ended || @day_ended

    # if the player beat the boss
    if @fight.ended && @fight.monster&.is_boss && @fight.player.currenthp > 0
      return redirect_to select_prize_fights_path(player_id: @player.id, fight_id: @fight.id)
    end

    Rails.logger.info "Hours: #{@player.hours} with ended: #{@player.day_ended?} and disable: #{@disable_actions}"
  end
end
