require 'rails_helper'

# Feature 2:
#   As an unauthorized user
#   I want to see an individual catch
#   So I can find out more information about how the fish was caught
#
#   Happy Path:
#     [X] I can click on a link for a specific catch from the list of catches
#     [X] I am brought to a page that shows what fish was caught, what lure was used, who caught the fish, what day/time they caught the fish, a picture of the fish(if available) and any other optional information they might have reported

feature "user visits an individual catch page" do
  let!(:catch_1) { create :catch }
  let!(:catch_2) { create :catch }
  scenario "user clicks on catch from Recent Catches Page" do
    visit root_path
    click_link "Recent Catches"
    click_link catch_1.caught_at
    expect(page).to have_content(catch_1.user.username)
    expect(page).to have_content(catch_1.zipcode)
    expect(page).to have_content(catch_1.caught_at)
    expect(page).to have_content(catch_1.fish_type.name)
    expect(page).to have_content(catch_1.lure.name)
    expect(page).to have_content(catch_1.lure.manufacturer)
    expect(page).to have_content(catch_1.lure.category)
  end
end
