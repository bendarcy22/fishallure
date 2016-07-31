require 'rails_helper'

feature "user views catches page" do
  let!(:fish_1) { create :fish_type, name: "Striped Bass" }
  let!(:lure_1) { create :lure, name: "White Pintail" }
  let!(:catch_1) { create :catch, fish_type: fish_1, lure: lure_1, caught_at: "2016-03-03" }
  let!(:catch_2) { create :catch }
  scenario "user inputs nothing into form" do
    visit root_path
    click_button "Recent Catches"
    click_link "All Recent Catches"

    expect(page).to have_content "All Catches"
    expect(page).to have_link(catch_1.caught_at.strftime("Caught on %m/%d/%Y"))
    expect(page).to have_link(catch_1.lure.name)
    expect(page).to have_link(catch_1.fish_type.name)
    expect(page).to have_link(catch_2.caught_at.strftime("Caught on %m/%d/%Y"))
    expect(page).to have_link(catch_2.lure.name)
    expect(page).to have_link(catch_2.fish_type.name)
  end
  scenario "user inputs nothing into form" do
    visit root_path
    click_button "Recent Catches"
    click_button "Search Recent Catches"

    expect(page).to have_content "Most Recent Catches"
    expect(page).to have_link(catch_1.caught_at.strftime("Caught on %m/%d/%Y"))
    expect(page).to have_link(catch_1.lure.name)
    expect(page).to have_link(catch_1.fish_type.name)
    expect(page).to have_link(catch_2.caught_at.strftime("Caught on %m/%d/%Y"))
    expect(page).to have_link(catch_2.lure.name)
    expect(page).to have_link(catch_2.fish_type.name)
  end
  scenario "user searches by fish type" do
    visit root_path
    click_button "Recent Catches"
    within(:css, "#catches-dropdown") do
      fill_in 'Fish', with: 'Striped'
    end
    click_button "Search Recent Catches"
    expect(page).to have_content "Most Recent Catches"
    expect(page).to have_content "These catches matched your search request: Striped"
    expect(page).to have_link(catch_1.caught_at.strftime("Caught on %m/%d/%Y"))
    expect(page).to have_link(catch_1.lure.name)
    expect(page).to have_link(catch_1.fish_type.name)
    expect(page).to_not have_link(catch_2.caught_at.strftime("Caught on %m/%d/%Y"))
    expect(page).to_not have_link(catch_2.lure.name)
    expect(page).to_not have_link(catch_2.fish_type.name)
  end
  scenario "user searches unsuccessfully by fish" do
    visit root_path
    click_button "Recent Catches"
    within(:css, "#catches-dropdown") do
      fill_in 'Fish', with: 'Not Gonna Work'
    end
    click_button "Search Recent Catches"

    expect(page).to have_content "Most Recent Catches"
    expect(page).to have_content "Sorry, there are no reported catches matching your search request: Not Gonna Work"
  end
  scenario "user searches by lure" do
    visit root_path
    click_button "Recent Catches"
    within(:css, "#catches-dropdown") do
      fill_in 'Lure', with: 'White'
    end
    click_button "Search Recent Catches"

    expect(page).to have_content "Most Recent Catches"
    expect(page).to have_content "These catches matched your search request: White"
    expect(page).to have_link(catch_1.caught_at.strftime("Caught on %m/%d/%Y"))
    expect(page).to have_link(catch_1.lure.name)
    expect(page).to have_link(catch_1.fish_type.name)
    expect(page).to_not have_link(catch_2.caught_at.strftime("Caught on %m/%d/%Y"))
    expect(page).to_not have_link(catch_2.lure.name)
    expect(page).to_not have_link(catch_2.fish_type.name)
  end
  scenario "user searches unsuccessfully by lure" do
    visit root_path
    click_button "Recent Catches"
    within(:css, "#catches-dropdown") do
      fill_in 'Lure', with: 'Not Gonna Work'
    end
    click_button "Search Recent Catches"

    expect(page).to have_content "Most Recent Catches"
    expect(page).to have_content "Sorry, there are no reported catches matching your search request: Not Gonna Work"
  end
end
