require 'rails_helper'

feature "user attempts to edit catch" do
  let!(:lure_1) { create :lure, name: "BestLure" }
  let!(:lure_2) { create :lure, name: "OkayLure" }
  let!(:fish_1) { create :fish_type, name: "Striped Bass" }
  let!(:fish_2) { create :fish_type, name: "Black Sea Bass" }
  scenario "user edits catch successfully" do
    report_a_catch
    click_link("Update your Catch")
    select "Black Sea Bass", from: "Fish"
    select "OkayLure", from: "Lure"
    attach_file "Add a picture of your catch!", "#{Rails.root}/spec/support/images/photo.png"
    click_button("Update Catch")

    expect(page).to have_content "Your catch was updated successfully"
    expect(page).to have_content "Striped Bass"
    expect(page).to have_content "BestLure"
    expect(page).to have_content(lure_1.category)
    expect(page).to have_css("img[src*='photo.png']")
  end
  scenario "user edits catch unsuccessfully" do
    report_a_catch
    click_link("Update your Catch")
    fill_in "Latitude", with: ""
    fill_in "Longitude", with: ""
    click_button("Update Catch")

    expect(page).to have_content "Latitude can't be blank"
    expect(page).to have_content "Longitude can't be blank"
  end
  scenario "user that didn't create catch can't edit catch" do
    report_a_catch
    sign_out
    sign_in_as_dummy
    visit catches_path
    click_link "Caught on 01/01/2016"
    expect(page).to have_content "Striped Bass"
    expect(page).to have_content "BestLure"
    expect(page).to_not have_link "Update your catch"
  end
end
