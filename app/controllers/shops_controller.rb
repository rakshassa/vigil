class ShopsController < ApplicationController
  before_action :set_player
  # before_action :ensure_no_fight
  before_action :default_disables

  def alchemist
    @message = params[:message]
  end

  def buy_potion
    item = PlayerPotion.where(player_id: @player.id, potion_id: params[:potion_id], bought: false).first
    return redirect_to alchemist_shops_path(player_id: @player.id, message: "The alchemist says 'That is NOT for sale.'") if item.blank?
    return redirect_to alchemist_shops_path(player_id: @player.id, message: "The can't carry any more potions.") unless @player.can_carry_another_potion?
    return redirect_to alchemist_shops_path(player_id: @player.id, message: "The alchemist grumbles when he realizes you can't afford that.") unless @player.can_afford_potion?(item.potion)

    message = "The alchemist hands you a #{item.potion.name}."
    if PlayerTrinket.accumulate(@player.id, "AlchemyAction") < 0
      # nothing more needs to be said
    else
      message += "<br>You wait while he constructs your order."
    end

    @player.buy_potion(item)
    redirect_to dash_menus_path(player_id: @player.id, message: message)
  end

  def use_potion
    item = PlayerPotion.where(player_id: @player.id, potion_id: params[:potion_id], bought: true).first
    return redirect_to dash_menus_path(player_id: @player.id, message: "You have trouble finding that potion in your backpack.") if item.blank?

    message = @player.use_potion(item)
    redirect_back(fallback_location: dash_menus_path(player_id: @player.id, message: message))
  end

  def discard_potion
    item = PlayerPotion.where(player_id: @player.id, potion_id: params[:potion_id], bought: true).first
    return redirect_to dash_menus_path(player_id: @player.id, message: "You have trouble finding that potion in your backpack.") if item.blank?

    item.destroy

    message = "You toss the potion into the bushes."
    redirect_back(fallback_location: dash_menus_path(player_id: @player.id, message: message))
  end

  def jeweler
    @message = params[:message]
  end

  def buy_trinket
    item = PlayerTrinket.where(player_id: @player.id, trinket_id: params[:trinket_id], bought: false).first
    return redirect_to jeweler_shops_path(player_id: @player.id, message: "The jeweler says 'That is NOT for sale.'") if item.blank?
    return redirect_to jeweler_shops_path(player_id: @player.id, message: "The jeweler grumbles when he realizes you can't afford that.") unless @player.can_afford_trinket?(item.trinket)

    message = "The jeweler hands you a #{item.trinket.name}."
    if PlayerTrinket.accumulate(@player.id, "JewelryAction") < 0
      # nothing more needs to be said
    else
      message += "<br>You wait while he constructs your order."
    end

    @player.buy_trinket(item)
    redirect_to dash_menus_path(player_id: @player.id, message: message)
  end

  def shop
    @message = params[:message]
  end

  def shop_weapons
    @message = params[:message]
  end

  def shop_armor
    @message = params[:message]
  end

  def buy_weapon
    item = Weapon.find(params[:weapon_id])
    return redirect_to shop_weapons_shops_path(player_id: @player.id, message: "The shopkeeper grumbles when he realizes you can't afford that.") unless @player.can_afford_weapon?(item)

    olditem = Weapon.find(@player.weapon_id)
    message = "The shopkeeper hands you your new #{item.name} and tosses your old #{olditem.name} into the forge."
    if PlayerTrinket.accumulate(@player.id, "ShopAction") < 0
      message += "<br>He is impressed when you already know how to use it."
    else
      message += "<br>You spend some time training with it."
    end

    @player.buy_weapon(item)
    redirect_to dash_menus_path(player_id: @player.id, message: message)
  end

  def buy_armor
    item = Armor.find(params[:armor_id])
    return redirect_to shop_armor_shops_path(player_id: @player.id, message: "The shopkeeper grumbles when he realizes you can't afford that.") unless @player.can_afford_armor?(item)

    olditem = Armor.find(@player.armor_id)
    message = "The shopkeeper hands you your new #{item.name} and tosses your old #{olditem.name} into the kiln.<br>You spend some time training in it."
    @player.buy_armor(item)
    redirect_to dash_menus_path(player_id: @player.id, message: message)
  end
end
