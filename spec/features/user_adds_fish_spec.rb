require 'rails_helper'

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
