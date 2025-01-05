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
end
