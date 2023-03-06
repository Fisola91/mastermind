require "rails_helper"

RSpec.describe "color picker" do
  it "mimics adding colored pegs to the board" do
    visit "/"

    find(".color-picker div[data-color=red]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")

    find(".color-picker div[data-color=green]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-green[data-number='1']")

    find(".color-picker div[data-color=orange]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-green[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='2']")

    find(".color-picker div[data-color=blue]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-green[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='2']")
    expect(find(".current-attempt")).to have_selector(".bg-blue[data-number='3']")

    find(".color-picker div[data-color=blue]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-green[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='2']")
    expect(find(".current-attempt")).to have_selector(".bg-blue[data-number='3']")
  end
end
