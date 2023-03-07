require "rails_helper"

RSpec.describe "unauthorised user" do
  it "cannot play on the board, but can login" do
    visit "/"
    expect(page).to_not have_css(".board")
    expect(page).to have_field "Player name"
  end
end
