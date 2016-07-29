require 'rails_helper'

# Feature 3:
#   As an unauthorized user
#   I want to see all the lures that have been used recently
#   So I can see what the hottest lures are right now
#
#   Happy Path:
#     [X] On the home page there is a link to "Hottest Lures"
#     [ ] There is a form where I can optionally provide a zip code, or a type of fish
#     [ ] Providing a zip code that has information associated with it takes me to a page with all the lures that have been reported in the past week near that zip code
#     [ ] If I entered a type of fish I am only shown the lures that have caught that type of fish
#     [X] The page shows the lures in order of most reported over the past week
#     [X] The lures are all links to the individual lures page
#
#   Unhappy Path:
#     [ ] If I provide a zip code inaccurately, I am shown an error message and given the form again
#     [ ] If I provide a zip code that doesn't have any reported catches near it, I am given a warning that the zip code I entered doesn't have any reported catches and I am being redirected to the nearest zip code that does have reported catches
#     [ ] If I provide a fish's name inaccurately, I am shown an error message and given the form again

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
    expect(page).to have_content "These lures matched your search by fish: Striped"
    expect(page).to have_content "Recent Hot Lures"
    expect(page).to have_content('BadLure', count: 1)
    expect(page).to_not have_content('BestLure')
    expect(page).to_not have_content('OkayLure')
  end
end
