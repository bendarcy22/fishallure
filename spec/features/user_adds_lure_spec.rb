require 'rails_helper'

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
