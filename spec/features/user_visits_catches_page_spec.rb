require 'rails_helper'

# Feature 1:
#
#   As an unauthorized user
#   I want to view the most recent catches in my area
#   So that I can see what is being caught around me
#
#   Happy Path:
#     [X] On the home page there is a link to "Recent Catches"
#     [ ] There is a form where I can optionally provide a zip code, or a type of fish
#     [ ] If I've entered valid information, I am taken to the Recent Catches page
#     [ ] If I entered a zip code I am shown a list of results for catches reported in my zip code
#     [ ] If I did't enter a zip code I am shown a list of all the catches reported
#     [ ] If I entered a type of fish I am only shown the catches of that fish
#     [X] The catches are links to more specific information about the catch and are sorted by most recent first
#     [X] The list of catches also show the information about what fish was caught and what lure was used (the lure and fish are both links).
#
#   Unhappy Path:
#     [ ] If I provide a zip code inaccurately, I am shown an error message and given the form again
#     [ ] If I provide a fish's name inaccurately, I am shown an error message and given the form again

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
    expect(page).to have_link(catch_1.caught_at)
    expect(page).to have_link(catch_1.lure.name)
    expect(page).to have_link(catch_1.fish_type.name)
    expect(page).to have_link(catch_2.caught_at)
    expect(page).to have_link(catch_2.lure.name)
    expect(page).to have_link(catch_2.fish_type.name)
  end
  scenario "user inputs nothing into form" do
    visit root_path
    click_button "Recent Catches"
    click_button "Search Recent Catches"

    expect(page).to have_content "Most Recent Catches"
    expect(page).to have_link(catch_1.caught_at)
    expect(page).to have_link(catch_1.lure.name)
    expect(page).to have_link(catch_1.fish_type.name)
    expect(page).to have_link(catch_2.caught_at)
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
    expect(page).to have_link(catch_1.caught_at)
    expect(page).to have_link(catch_1.lure.name)
    expect(page).to have_link(catch_1.fish_type.name)
    expect(page).to_not have_link(catch_2.caught_at)
    expect(page).to_not have_link(catch_2.lure.name)
    expect(page).to_not have_link(catch_2.fish_type.name)
  end
  scenario "user searches by lure" do
    visit root_path
    click_button "Recent Catches"
    within(:css, "#catches-dropdown") do
      fill_in 'Lure', with: 'White'
    end
    click_button "Search Recent Catches"

    expect(page).to have_content "Most Recent Catches"
    expect(page).to have_link(catch_1.caught_at)
    expect(page).to have_link(catch_1.lure.name)
    expect(page).to have_link(catch_1.fish_type.name)
    expect(page).to_not have_link(catch_2.caught_at)
    expect(page).to_not have_link(catch_2.lure.name)
    expect(page).to_not have_link(catch_2.fish_type.name)
  end
end
