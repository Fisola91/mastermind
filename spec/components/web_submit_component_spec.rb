# frozen_string_literal: true

require "rails_helper"

RSpec.describe WebSubmitComponent, type: :component do
  let(:params) do
    {
      "current_attempt"=>"0",
      "controller"=>"web_games",
      "action"=>"player_guess",
      "code1"=>"RED",
      "code2"=>"GREEN",
      "code3"=>"BLUE",
      "code4"=>"YELLOW"}
  end

  context "when player make a guess" do
    let(:action)  { WebSubmitComponent.new(params: params, view: @view) }
    it "renders player guess" do
      @view = action.view
      render_inline(WebSubmitComponent.new(params: @params, view: @view))
      expect(page).to have_css("h3", text: "Guess!")
    end
  end
end
