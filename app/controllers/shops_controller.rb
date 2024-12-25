class ShopsController < ApplicationController
  before_action :set_player
  before_action :ensure_no_fight
  before_action :default_disables

  def jeweler
    @message = params[:message]
  end

  def buy_trinket
    item = Trinket.find(params[:trinket_id])
    return redirect_to jeweler_shops_path(@player, message: "The jeweler grumbles when he realizes you can't afford that.") unless @player.can_afford_trinket?(item)

    message = "The jeweler hands you a #{item.name}.<br>You spend some time training with it."
    @player.buy_trinket(item)
    redirect_to dash_menus_path(@player, message: message)
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
    return redirect_to shop_weapons_shops_path(@player, message: "The shopkeeper grumbles when he realizes you can't afford that.") unless @player.can_afford_weapon?(item)

    olditem = Weapon.find(@player.weapon_id)
    message = "The shopkeeper hands you your new #{item.name} and tosses your old #{olditem.name} into the forge.<br>You spend some time training with it."
    @player.buy_weapon(item)
    redirect_to dash_menus_path(@player, message: message)
  end

  def buy_armor
    item = Armor.find(params[:armor_id])
    return redirect_to shop_armor_shops_path(@player, message: "The shopkeeper grumbles when he realizes you can't afford that.") unless @player.can_afford_armor?(item)

    olditem = Armor.find(@player.armor_id)
    message = "The shopkeeper hands you your new #{item.name} and tosses your old #{olditem.name} into the kiln.<br>You spend some time training in it."
    @player.buy_armor(item)
    redirect_to dash_menus_path(@player, message: message)
  end
end
