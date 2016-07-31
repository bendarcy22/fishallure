require 'rails_helper'

feature "user redirected from report your catch page" do
  scenario "user signs up successfully after being redirected from Report your Catch page" do
    visit root_path
    click_link "Report your Catch"
    click_link "Sign up"

    fill_in 'Email', with: 'catchallthefish@gmail.com'
    fill_in 'Username', with: 'catchallthefish'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(page).to have_content "Report what you caught here!"
  end
  scenario "user signs up with invalid info" do
    visit root_path
    click_link "Report your Catch"
    click_link "Sign up"

    click_on 'Sign up'

    expect(page).to have_content "errors prohibited this user from being saved"
  end
  scenario "user signs in with only username and password" do
    log_in_user
    click_link "Sign Out"
    visit root_path
    click_link "Report your Catch"

    fill_in 'Login', with: 'catchallthefish'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end
end
