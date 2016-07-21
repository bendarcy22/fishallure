require 'rails_helper'

# Feature 5:
#   As an unauthorized user
#   I want to see an individual lures page to see a brief description of the lure
#   So I can understand what type of lure it is and how well it is doing
#
#   Happy Path:
#     [X] I can click on the lures name from either a reported catch post or from the list of lures
#     [X] The page shows me what size, color and category the lure can come in
#     [ ] The page shows me a picture of the lure (if available)
#     [X] The page shows me what type of fish are being caught on the lure
#     [ ] The page shows me how many fish have been caught on this lure over the past week
#     [ ] The page shows me where the fish have been caught on this lure over the past week

feature "user sees individual lures page" do
  let!(:lure_1) { create :lure, name: "OkayLure", description: "This lure works best when retrieved slowly. It comes in: Green, Yellow, Pink, and Brown." }
  let!(:lure_2) { create :lure, name: "BadLure" }
  let!(:catch_1) { create :catch, lure: lure_1 }
  let!(:catch_2) { create :catch, lure: lure_1 }
  let!(:catch_3) { create :catch, lure: lure_1 }
  let!(:catch_4) { create :catch, lure: lure_2 }

  scenario "click on name of the lure from reported catch post" do
    visit root_path
    click_link "Recent Catches"
    click_link('OkayLure', match: :first)
    expect(page).to have_content(lure_1.name)
    expect(page).to have_content(lure_1.manufacturer)
    expect(page).to have_content(lure_1.category)
    expect(page).to have_content(lure_1.description)
    expect(page).to have_content(catch_1.fish_type.name)
    expect(page).to have_content(catch_2.fish_type.name)
    expect(page).to have_content(catch_3.fish_type.name)
    expect(page).to_not have_content(catch_4.fish_type.name)
  end
end
