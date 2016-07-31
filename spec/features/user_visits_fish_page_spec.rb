require 'rails_helper'

feature "user sees individual fishs page" do
  let!(:fish_1) { create :fish_type, name: "Okayfish", description: "This fish lives in shallow marshy ares. It eats everything it sees" }
  let!(:fish_2) { create :fish_type, name: "Badfish" }
  let!(:catch_1) { create :catch, fish_type: fish_1 }
  let!(:catch_2) { create :catch, fish_type: fish_1 }
  let!(:catch_3) { create :catch, fish_type: fish_2 }

  scenario "click on name of the fish from reported catch post" do
    visit root_path
    click_button "Recent Catches"
    click_link "All Recent Catches"

    click_link('Okayfish', match: :first)
    expect(page).to have_content(fish_1.name)
    expect(page).to have_content(fish_1.description)
    expect(page).to have_content(catch_1.lure.name)
    expect(page).to have_content(catch_2.lure.name)
    expect(page).to_not have_content(catch_3.lure.name)
  end
end
