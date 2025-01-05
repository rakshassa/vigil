class FightsController < ApplicationController
  before_action :set_fight, except: %w[boss]
  before_action :set_fight_player

  def select_prize
    unless @fight.ended && @fight.monster.is_boss && @fight.player.currenthp > 0
      message = "You have not earned a prize, yet."
      return redirect_to dash_menus_path(player_id: @player.id, message: message)
    end

    # give prize selections
    @player.player_trinkets.where(bought: false).destroy_all

    max = Setting.boss_prizes(@player.id)
    @player.add_jewelry_shop_inventory(max)
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
