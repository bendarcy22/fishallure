require 'rails_helper'

feature "user visits personal catch page" do
  let!(:lure_1) { create :lure, name: "BestLure" }
  let!(:lure_2) { create :lure, name: "OkayLure" }
  let!(:fish_1) { create :fish_type, name: "Striped Bass" }
  let!(:fish_2) { create :fish_type, name: "Black Sea Bass" }
  let!(:catch_1) { create :catch, lure: lure_1, fish_type: fish_2 }
  scenario "user reports two catches and then visits personal page" do
    report_a_catch
    click_link "Report your Catch"
    expect(page).to have_content "Report what you caught here!"
    select "Striped Bass", from: "Fish"
    select "OkayLure", from: "Lure"
    fill_in "Latitude", with: "0"
    fill_in "Longitude", with: "0"
    fill_in "Caught on", with: "2016/02/02"
    click_button("Report it!")

    click_link "My Catches"
    expect(page).to have_content("Your Catches")
    expect(page).to have_link("Caught on 01/01/2016")
    expect(page).to have_link("Caught on 02/02/2016")
    expect(page).to have_link("BestLure", count: 1)
    expect(page).to have_link("OkayLure", count: 1)
    expect(page).to have_link("Striped Bass", count: 2)
    expect(page).to_not have_link("Black Sea Bass")
  end
end
