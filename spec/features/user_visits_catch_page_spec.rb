require 'rails_helper'

feature "user visits an individual catch page" do
  let!(:catch_1) { create :catch }
  let!(:catch_2) { create :catch }
  scenario "user clicks on catch from Recent Catches Page" do
    visit root_path
    click_button "Recent Catches"
    click_link "All Recent Catches"
    click_link(catch_1.caught_at.strftime("Caught on %m/%d/%Y"), match: :first)
    expect(page).to have_content(catch_1.user.username)
    expect(page).to have_content(catch_1.caught_at.strftime("Caught on %m/%d/%Y"))
    expect(page).to have_content(catch_1.fish_type.name)
    expect(page).to have_content(catch_1.lure.name)
    expect(page).to have_content(catch_1.lure.manufacturer)
    expect(page).to have_content(catch_1.lure.category)
  end
end
