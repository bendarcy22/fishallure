require 'rails_helper'

# Feature 11:
#   As a signed in user
#   I want to be able to report a catch but the database doesn't have the lure I used
#   I want to be able to add a lure
#   So I can reference it in my catch
#
#   Happy Path:
#     [ ] If I navigate to the "Report a Catch" form and the lure I used isn't in the dropdown menu, there is an option in the dropdown menu to "Add a New Lure"
#     [ ] If I select the "Add a New Lure" option, I am redirected to a form for adding a new lure
#     [ ] The form requires that I input the name of the lure, the manufacturer, the category of lure it belongs to(from a dropdown menu) and optionally I can add a short description as well a picture of the lure
#     [ ] If I provide valid information, I am shown a message that says the lure was added successfully and then I am sent to that lures page where links to edit or delete the lure appear
#
#   Unhappy Path:
#     [ ] If I provide invalid information, such as if the lure I tried adding already exists in the database, I am shown an error message letting me know that that lure already exists, and I stay on the form page for adding a new lure

feature "user adds a new lure" do
  scenario "user adds lure successfully" do
    log_in_user
    click_link "Report your Catch"
    click_link "Add a Lure"
    expect(page).to have_content "Add a lure to our database:"
    fill_in "Name", with: "BestLure"
    fill_in "Manufacturer", with: "Lunker City"
    select "Jig", from: "Category"
    attach_file "Picture of Lure", "#{Rails.root}/spec/support/images/photo.png"
    click_button("Add the Lure")

    expect(page).to have_content "The Lure has been added!"
    expect(page).to have_content "BestLure"
    expect(page).to have_content "Lunker City"
    expect(page).to have_css("img[src*='photo.png']")
  end

  scenario "user attempts to add same lure twice" do
    log_in_user
    click_link "Report your Catch"
    click_link "Add a Lure"
    expect(page).to have_content "Add a lure to our database:"
    fill_in "Name", with: "BestLure"
    fill_in "Manufacturer", with: "Lunker City"
    select "Jig", from: "Category"
    attach_file "Picture of Lure", "#{Rails.root}/spec/support/images/photo.png"
    click_button("Add the Lure")

    click_link "Report your Catch"
    click_link "Add a Lure"
    expect(page).to have_content "Add a lure to our database:"
    fill_in "Name", with: "BestLure"
    fill_in "Manufacturer", with: "Lunker City"
    select "Jig", from: "Category"
    attach_file "Picture of Lure", "#{Rails.root}/spec/support/images/photo.png"
    click_button("Add the Lure")
    expect(page).to have_content "That lure is already in the database"
    expect(page).to have_content "Add a lure to our database:"
  end

  scenario "user unsuccessfully adds lure" do
    log_in_user
    click_link "Report your Catch"
    click_link "Add a Lure"
    click_button("Add the Lure")
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Manufacturer can't be blank"
    expect(page).to have_content "Category can't be blank"
  end
end
