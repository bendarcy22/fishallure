require 'rails_helper'

feature "user sees individual lures page" do
  let!(:lure_1) { create :lure, name: "OkayLure", description: "This lure works best when retrieved slowly. It comes in: Green, Yellow, Pink, and Brown." }
  let!(:lure_2) { create :lure, name: "BadLure" }
  let!(:catch_1) { create :catch, lure: lure_1 }
  let!(:catch_2) { create :catch, lure: lure_1 }
  let!(:catch_3) { create :catch, lure: lure_1 }
  let!(:catch_4) { create :catch, lure: lure_2 }

  scenario "click on name of the lure from reported catch post" do
    visit root_path
    click_button "Recent Catches"
    click_link "All Recent Catches"

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
