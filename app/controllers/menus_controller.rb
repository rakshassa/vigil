class MenusController < ApplicationController
  before_action :set_player, except: %i[login start_game]
  before_action :ensure_no_fight, except: %i[wilderness]
  before_action :default_disables

  def bard
  end

  def bard_buff
    redirect_to dash_menus_path(@player, message: 'Jaskier is too tired to perform again today.') if @player.used_bard

    message = @player.bard_buff
    redirect_to dash_menus_path(@player, message: message)
  end

  def healer
  end

  def heal
    @player.heal
    redirect_to dash_menus_path(@player, message: 'You heal as much as you can afford.')
  end

  def training
  end

  def train
    return redirect_to dash_menus_path(@player, message: 'You are not ready to train.') unless @player.can_level?
    return redirect_to dash_menus_path(@player, message: "You can't afford to train.") if @player.gold < @player.next_level.gold

    message = @player.level_up
    redirect_to dash_menus_path(@player, message: message)
  end

  def login
  end

  def start_game
    Player.destroy_all

    record = Player.create(
      level_id: Level.first.id, maxhp: 10, currenthp: 10, gold: 0, gems: 0, baseatk: 5, basedef: 1,
      skills: 1, baseskills: 1, used_bard: false,
      weapon_id: Weapon.first.id, armor_id: Armor.first.id, days: 0, hours: 0, exp: 0
    )
    redirect_to dash_menus_path(id: record.id)
  end

  def dash
    @day_ended = @player.day_ended?

    @message = params[:message]
    @message += "<br>" unless @message.blank?
    @message = "#{@message}A dangerous foe approaches.  You prepare yourself - your skills are refreshed!" if @day_ended
    @message = "Welcome to Vigil.<br><br>What would you like to do?" if @message.blank?
  end

  def wilderness
    Rails.logger.info "Params in wilderness: #{params}"
    records = Fight.where(player_id: @player.id, ended: false)
    raise ActionController::BadRequest.new(), "More than one ongoing fight." if records.count > 1

    fight_id = params[:fight_id]&.to_i
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
    Rails.logger.info "Hours: #{@player.hours} with ended: #{@player.day_ended?} and disable: #{@disable_actions}"
  end
end
