class MenusController < ApplicationController
  def dash
    # TODO: populate the content_panel
  end

  def wilderness
    # TODO: populate the content_panel
    redirect_to dash_menus_path
  end
end
