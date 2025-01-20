module ActionsHelper
  def action_link(button_name, hotkey, path, flag: false)
    actual_hotkey = @disable_actions ? nil : hotkey

    content_tag(:div) do
      result = tag.span(hotkey, class: "badge badge-pill bg-success left_action_badge")
      result += link_to(button_name, path, :class => "action_btn btn btn-info rounded-pill", "data-hotkey" => actual_hotkey)
      result += tag.span("!", class: "badge badge-pill bg-danger right_action_badge") if flag

      result
    end
  end

  def choice_link(choice_number)
    record = @fight.encounter.get_choice(choice_number)
    return "" if record.blank?

    disabled = cant_afford_cost(record["cost"]) # cost: { gold: 0, jewels: 1 }

    content_tag(:div, class: "col") do
      result = tag.span(choice_number, class: "badge badge-pill bg-success left_action_badge")
      result += button_to(record["action"], choice_fights_path, params: { fight_id: @fight.id, player_id: @player.id, action_id: choice_number }, :class => "action_btn btn btn-info rounded-pill", "data-hotkey" => choice_number, disabled: disabled)
    end
  end

  def cant_afford_cost(cost)
    return false if cost.blank?

    gold = cost["gold"].nil? ? 0 : cost["gold"]
    jewels = cost["jewels"].nil? ? 0 : cost["jewels"]
    return true if gold > @player.gold
    return true if jewels > @player.gems

    false
  end
end

def road_link(record, counter)
  # TODO: view should badge monsters vs encounters with crossed-swords vs question-mark
  road_name = record.monster_id.nil? ? record.encounter.short_name : record.monster.name

  # this is where we add the contents to result so they can be accumulated
  content_tag(:div, class: "col") do
    body = tag.span(counter, class: "badge badge-pill bg-success left_action_badge")
    if record.encounter_id.nil?
      body += tag.span(class: "badge badge-pill bg-danger road_type_badge") do
        content_tag(:i, "", class: "bi bi-crosshair")
      end
    else
      body += tag.span(class: "badge badge-pill bg-warning road_type_badge") do
        content_tag(:i, "", class: "bi bi-question")
      end
    end
    body += button_to(road_name, select_road_menus_path, params: { road_id: record.id, player_id: @player.id }, :class => "action_btn btn btn-info rounded-pill", "data-hotkey" => counter)
  end
end
