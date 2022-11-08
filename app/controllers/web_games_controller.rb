require "./app/web_ui"
class WebGamesController < ApplicationController
  def index
    @view = WebUI.new
  end
end
