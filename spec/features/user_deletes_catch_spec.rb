require 'rails_helper'
feature "user deletes catch" do
  let!(:lure_1) { create :lure, name: "BestLure" }
  let!(:fish_1) { create :fish_type, name: "Striped Bass" }
  scenario "user deletes a catch successfully" do
    report_a_catch
    click_link "Delete your Catch"
    expect(page).to have_content "Catch deleted successfully"
  end
  scenario "user that didn't create catch can't delete catch" do
    report_a_catch
    sign_out
    sign_in_as_dummy
    visit catches_path
    click_link "Caught on 01/01/2016"
    expect(page).to have_content "Striped Bass"
    expect(page).to have_content "BestLure"
    expect(page).to_not have_link "Delete your catch"
  end
end
