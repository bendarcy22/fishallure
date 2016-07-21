require 'rails_helper'

# Feature 10:
#   As a signed in user
#   I want to be able to report a catch but the database doesn't have the fish I caught
#   I want to be able to add a fish
#   So I can reference it in my catch
#
#   Happy Path:
#     [X] If I navigate to the "Report a Catch" form and the fish I caught isn't in the dropdown menu, there is a link next to the dropdown menu to "Add a New Fish"
#     [X] If I select the "Add a New Fish" option, I am redirected to a form for adding a new fish
#     [X] The form requires that I input the name of the fish and optionally add a short description as well as adding a picture of the fish
#     [X] If I provide valid information, I am shown a message that says the fish was added successfully and then I am sent to that fish's page where links to edit or delete the fish appear
#
#   Unhappy Path:
#     [X] If I provide invalid information, such as if the fish I tried adding already exists in the database, I am shown an error message letting me know that that fish already exists, and I stay on the form page for adding a new fish

feature "user adds a new fish" do
  scenario "user adds fish successfully" do
    log_in_user
    click_link "Report your Catch"
    click_link "Add a Fish"
    expect(page).to have_content "Add a fish to our database:"
    fill_in "Name", with: "Bluefish"
    fill_in "Brief Description (optional)", with: "Aggressive piranha of the northeast Atlantic, very fishy taste."
    attach_file "Picture of Fish", "#{Rails.root}/spec/support/images/photo.png"
    click_button("Add the Fish")

    expect(page).to have_content "The Fish has been added!"
    expect(page).to have_content "Bluefish"
    expect(page).to have_content "Aggressive piranha of the northeast Atlantic, very fishy taste."
    expect(page).to have_css("img[src*='photo.png']")
  end

  scenario "user attempts to add same fish twice" do
    log_in_user
    click_link "Report your Catch"
    click_link "Add a Fish"
    expect(page).to have_content "Add a fish to our database:"
    fill_in "Name", with: "Bluefish"
    fill_in "Brief Description (optional)", with: "Aggressive piranha of the northeast Atlantic, very fishy taste."
    attach_file "Picture of Fish", "#{Rails.root}/spec/support/images/photo.png"
    click_button("Add the Fish")

    click_link "Report your Catch"
    click_link "Add a Fish"
    expect(page).to have_content "Add a fish to our database:"
    fill_in "Name", with: "Bluefish"
    fill_in "Brief Description (optional)", with: "Different Description"
    attach_file "Picture of Fish", "#{Rails.root}/spec/support/images/photo.png"
    click_button("Add the Fish")
    expect(page).to have_content "That fish is already in the database"
    expect(page).to have_content "Add a fish to our database:"
  end

  scenario "user unsuccessfully adds fish" do
    log_in_user
    click_link "Report your Catch"
    click_link "Add a Fish"
    click_button("Add the Fish")
    expect(page).to have_content "Name can't be blank"
  end
end
