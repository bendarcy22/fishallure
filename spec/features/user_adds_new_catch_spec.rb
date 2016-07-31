require 'rails_helper'

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
