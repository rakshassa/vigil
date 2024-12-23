class ShopsController < ApplicationController
  before_action :set_player
  before_action :ensure_no_fight
  before_action :default_disables

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
    message = "The shopkeeper hands you your new #{item.name} and tosses your old #{olditem.name} into the trash."
    @player.buy_weapon(item)
    redirect_to shop_shops_path(@player, message: message)
  end

  def buy_armor
    item = Armor.find(params[:armor_id])
    return redirect_to shop_armor_shops_path(@player, message: "The shopkeeper grumbles when he realizes you can't afford that.") unless @player.can_afford_armor?(item)

    olditem = Armor.find(@player.armor_id)
    message = "The shopkeeper hands you your new #{item.name} and tosses your old #{olditem.name} into the trash."
    @player.buy_armor(item)
    redirect_to shop_shops_path(@player, message: message)
  end
end
