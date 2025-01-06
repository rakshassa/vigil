class MenusController < ApplicationController
  before_action :set_player, except: %i[login start_game]
  # before_action :ensure_no_fight, except: %i[wilderness]
  before_action :default_disables

  def bard
  end

  def bard_buff
    redirect_to dash_menus_path(player_id: @player.id, message: "Jaskier is too tired to perform again today.") if @player.used_bard

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

    @message = params[:message]
    @message += "<br>" unless @message.blank?
    if @day_ended
      @message += "A dangerous foe approaches."
      @disable_actions = true
    end

    @message = "Welcome to Vigil.<br><br>What would you like to do?" if @message.blank?
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
      @fight = EncounterSelector.new.select(@player)
      @player.increment_hours # new encounter takes an hour
      Rails.logger.info "Created Fight: #{@fight.id}"
    end
    @day_ended = @player.day_ended?
    @disable_actions = @player.is_dead? || !@fight.ended || @day_ended

    # if the player beat the boss
    if @fight.ended && @fight.monster.is_boss && @fight.player.currenthp > 0
      return redirect_to select_prize_fights_path(player_id: @player.id, fight_id: @fight.id)
    end

    Rails.logger.info "Hours: #{@player.hours} with ended: #{@player.day_ended?} and disable: #{@disable_actions}"
  end
end
