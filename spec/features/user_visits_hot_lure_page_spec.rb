require 'rails_helper'

feature "user views Hot Lures page" do
  let!(:lure_1) { create :lure, name: "OkayLure" }
  let!(:lure_2) { create :lure, name: "BadLure" }
  let!(:lure_3) { create :lure, name: "BestLure" }
  let!(:fish_1) { create :fish_type, name: "Striped Bass" }
  let!(:fish_2) { create :fish_type, name: "Bluefish" }
  let!(:catch_1) { create :catch, lure: lure_1, fish_type: fish_2 }
  let!(:catch_2) { create :catch, lure: lure_3, fish_type: fish_2 }
  let!(:catch_3) { create :catch, lure: lure_2, fish_type: fish_1 }
  let!(:catch_4) { create :catch, lure: lure_3 }
  let!(:catch_5) { create :catch, lure: lure_1 }
  let!(:catch_6) { create :catch, lure: lure_3 }
  scenario "user ignores form" do
    visit root_path
    click_button "Lures"
    click_link "All Lures"

    expect(page).to have_content "All Lures"
    expect(page).to have_content('BestLure', count: 1)
    expect(page).to have_content('OkayLure', count: 1)
    expect(page).to have_content('BadLure', count: 1)
  end
  scenario "user inputs nothing into form" do
    visit root_path
    click_button "Lures"
    click_button "Search Hot Lures"

    expect(page).to have_content "Recent Hot Lures"
    expect(page).to have_content('BestLure', count: 1)
    expect(page).to have_content('OkayLure', count: 1)
    expect(page).to have_content('BadLure', count: 1)
  end
  scenario "user searches form by fish type" do
    visit root_path
    click_button "Lures"
    within(:css, "#lures-dropdown") do
      fill_in 'Fish', with: 'Striped'
    end
    click_button "Search Hot Lures"
    expect(page).to have_content "Recent Hot Lures"
    expect(page).to have_content "These lures matched your search: Striped"
    expect(page).to have_content('BadLure', count: 1)
    expect(page).to_not have_content('BestLure')
    expect(page).to_not have_content('OkayLure')
  end
  scenario "user searches unsuccessfully" do
    visit root_path
    click_button "Lures"
    within(:css, "#lures-dropdown") do
      fill_in 'Fish', with: 'Not Gonna Work'
    end
    click_button "Search Hot Lures"
    expect(page).to have_content "Recent Hot Lures"
    expect(page).to have_content "Sorry, there are no reported lures matching your search request: Not Gonna Work"
  end
end
