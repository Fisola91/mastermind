# frozen_string_literal: true

require "rails_helper"


RSpec.describe WebUiComponent, type: :component do
  let(:view)  { WebUiComponent.new(view: @view) }

  it "renders the index page" do
    render_inline(WebUiComponent.new(view: view))
    expect(page).to have_text("Start a new game")
    expect(page).to have_text("Here's how we imagine the UI in the future")
    expect(page).to have_css(".board")
    # expect(page).to have_css "[class='color-picker']"
  end
end
