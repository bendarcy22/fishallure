require 'rails_helper'

# Feature 9:
#   As a signed in user
#   I want to report a catch
#   So other people can see what I have caught
#
#   Happy Path:
#     [X] If I click on the link in the nav bar to "Report a Catch", I am taken to the "Report a Catch" form
#     [X] The form provides me with instructions about what I should report about the catch
#     [X] The form requires me to input the type of fish I caught(from a dropdown menu), the lure I used(from a dropdown menu), the zip code from where I caught the fish and what day/time I caught the fish
#     [ ] The form also allows me to input a picture of the fish I caught
#     [ ] The form also allows me to input more specific locations as to where I caught it (hopefully Google Maps pins)
#     [ ] The form also allows me to add any other pertinent information that I feel like adding (such as directions to the place I caught the fish from or a specific condition that other fisherman should look for)
#     [X] After submitting the form correctly I am take to the catches individual page, where I can click a link to edit the post or I can click a link to delete the post
#
#   Unhappy Path:
#     [X] If I provide invalid information in the form I am shown an error message describing what went wrong and I am still on the form page with everything pre-filled

feature "user attempts to add new catch" do
  let!(:lure_1) { create :lure, name: "BestLure" }
  let!(:fish_1) { create :fish_type, name: "Striped Bass" }
  scenario "user adds catch successfully" do
    log_in_user
    click_link "Report your Catch"
    expect(page).to have_content "Report what you caught here!"
    select "Striped Bass", from: "Fish"
    select "BestLure", from: "Lure"
    fill_in "Latitude", with: "0"
    fill_in "Longitude", with: "0"
    fill_in "Caught on", with: "2016/01/01"
    attach_file "Add a picture of your catch!", "#{Rails.root}/spec/support/images/photo.png"
    click_button("Report it!")

    expect(page).to have_content "Your catch has been recorded!"
    expect(page).to have_content "Striped Bass"
    expect(page).to have_content "BestLure"
    expect(page).to have_content(lure_1.category)
    expect(page).to have_css("img[src*='photo.png']")
  end
  scenario "user adds catch unsuccessfully" do
    log_in_user
    click_link "Report your Catch"
    click_button("Report it!")
    expect(page).to have_content "Lure can't be blank"
    expect(page).to have_content "Fish type can't be blank"
    expect(page).to have_content "Latitude can't be blank"
    expect(page).to have_content "Longitude can't be blank"
  end
end
