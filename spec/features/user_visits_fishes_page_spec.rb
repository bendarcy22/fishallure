require 'rails_helper'

feature "user views Fish page" do
  let!(:lure_1) { create :lure, name: "White Pintail" }
  let!(:fish_1) { create :fish_type, name: "Striped Bass" }
  let!(:fish_2) { create :fish_type, name: "Bluefish" }
  let!(:fish_3) { create :fish_type, name: "Albacore" }
  let!(:catch_1) { create :catch, fish_type: fish_1, lure: lure_1 }
  let!(:catch_2) { create :catch, fish_type: fish_3 }
  let!(:catch_3) { create :catch, fish_type: fish_2, lure: lure_1 }
  let!(:catch_4) { create :catch, fish_type: fish_3 }
  let!(:catch_5) { create :catch, fish_type: fish_1, lure: lure_1 }
  let!(:catch_6) { create :catch, fish_type: fish_3 }
  scenario "user ignores form" do
    visit root_path
    click_button "Fish"
    click_link "All Fish"

    expect(page).to have_content "All Fish"
    expect(page).to have_content('Striped Bass', count: 1)
    expect(page).to have_content('Bluefish', count: 1)
    expect(page).to have_content('Albacore', count: 1)
  end
  scenario "user inputs nothing into form" do
    visit root_path
    click_button "Fish"
    click_button "Search Fish"

    expect(page).to have_content "Fish"
    expect(page).to have_content('Striped Bass', count: 1)
    expect(page).to have_content('Bluefish', count: 1)
    expect(page).to have_content('Albacore', count: 1)
    expect('Albacore').to appear_before('Striped Bass')
    expect('Striped Bass').to appear_before('Bluefish')
  end
  scenario "user searches by lure" do
    visit root_path
    click_button "Fish"
    within(:css, "#fish-type-dropdown") do
      fill_in 'Lure', with: 'Pintail'
    end
    click_button "Search Fish"

    expect(page).to have_content "Fish"
    expect(page).to have_content "These Fish matched your search: Pintail"
    expect(page).to have_content('Striped Bass', count: 1)
    expect(page).to have_content('Bluefish', count: 1)
    expect(page).to_not have_content('Albacore', count: 1)
    expect('Striped Bass').to appear_before('Bluefish')
  end
  scenario "user searches unsuccessfully" do
    visit root_path
    click_button "Fish"
    within(:css, "#fish-type-dropdown") do
      fill_in 'Lure', with: 'Not Gonna Work'
    end
    click_button "Search Fish"

    expect(page).to have_content "Fish"
    expect(page).to have_content "Sorry, there are no reported fish matching your search request: Not Gonna Work"
  end
end
