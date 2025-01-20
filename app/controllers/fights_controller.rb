class FightsController < ApplicationController
  before_action :set_fight, except: %w[boss]
  before_action :set_fight_player

  def choice
    return redirect_to dash_menus_path(player_id: @player.id) if @fight.ended

    Rails.logger.info "Params in Choice: #{params}"

    choice_value = @fight.encounter.get_choice(params[:action_id].to_i)
    Rails.logger.info "Processing Choice: #{choice_value}"
    return redirect_to dash_menus_path(player_id: @player.id) if choice_value.nil?

    effects = choice_value["effects"]
    roll = Rands.rand(1, 100)
    sum = 0

    effects.each do |effect|
      sum += effect["chance"]
      next if roll > sum

      message = @player.process_encounter_results(effect)
      @fight.update(message: message, ended: true)
      break
    end

    Rails.logger.info "Done processing Choice: #{@fight.message}"
    redirect_to wilderness_menus_path(player_id: @player.id, fight_id: @fight.id)
  end

  def select_prize
    unless @fight.ended && @fight.monster.is_boss && @fight.player.currenthp > 0
      message = "You have not earned a prize, yet."
      return redirect_to dash_menus_path(player_id: @player.id, message: message)
    end

    # how many prizes?
    max = Setting.boss_prizes(@player.id)

    # give prize selections as PlayerTrinket records (shop will repopulate after prize selection since day ends)
    @player.player_trinkets.where(bought: false).destroy_all
    @player.add_jewelry_shop_inventory(max)

    # force selection before moving on
    @disable_actions = true
  end

  def prize_selection
    unless @fight.ended && @fight.monster.is_boss && @fight.player.currenthp > 0
      message = "You have not earned a prize."
      @player.new_day # reset user and skip ahead to next day
      return redirect_to dash_menus_path(player_id: @player.id, message: message)
    end

    # give selected prize to player
    selection = PlayerTrinket.where(player_id: @player.id, id: params[:ptrinket_id]).first
    if selection.blank?
      message = "That is not one of your prizes."
    else
      selection.update(bought: true)
      selection.trinket.on_obtain(@player)
    end

    # start a new day
    @player.new_day
    message = @fight.message + "<br>A new day begins.  You feel refreshed!"
    @fight.update(message: message)
    redirect_to dash_menus_path(player_id: @player.id, message: message)
  end

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
