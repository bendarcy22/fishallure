require 'rails_helper'

# Feature 6:
#   As an unauthorized user
#   I want to see an individual fish page to see a brief description of the fish
#   So I can understand where the fish is being caught and what fishs are working best to catch it
#
#   Happy Path:
#     [ ] I can click on the fish's name from either a reported catch post or from the list of fish
#     [ ] The page shows me a brief description of the fish (where it is typically found, what it eats)
#     [ ] The page shows me a picture of the fish (if available)
#     [ ] The page shows me what lures are working well to catch the fish
#     [ ] The page shows me where this fish has been caught over the past week

feature "user sees individual fishs page" do
  let!(:fish_1) { create :fish_type, name: "Okayfish", description: "This fish lives in shallow marshy ares. It eats everything it sees" }
  let!(:fish_2) { create :fish_type, name: "Badfish" }
  let!(:catch_1) { create :catch, fish_type: fish_1 }
  let!(:catch_2) { create :catch, fish_type: fish_1 }
  let!(:catch_3) { create :catch, fish_type: fish_2 }

  scenario "click on name of the fish from reported catch post" do
    visit root_path
    click_link "Recent Catches"
    click_link('Okayfish', match: :first)
    expect(page).to have_content(fish_1.name)
    expect(page).to have_content(fish_1.description)
    expect(page).to have_content(catch_1.lure.name)
    expect(page).to have_content(catch_2.lure.name)
    expect(page).to_not have_content(catch_3.lure.name)
  end
end
