require 'rails_helper'

# Feature 7:
#   As an unauthorized user
#   I want to be able to sign up
#   So I can report my catch
#
#   Happy Path:
#     [X] On the nav bar there is a link to "Report your Catch"
#     [X] If I am not signed in, I am sent to a page that asks me to sign in or sign up
#     [X] The sign up page requests a username, an email, a password and a confirmed password
#     [x] If I enter all valid information, I am sent to the "Report your Catch" form
#
#   Unhappy Path:
#     [X] If I did not provide valid credentials, I receive the appropriate error message

# Feature 8:
#   As an unauthorized user
#   I want to sign in
#   So I can report my catch
#
#   Happy Path:
#     [ ] On the nav bar there is a link to "Report your Catch"
#     [ ] If I am not signed in, I am sent to a page that asks me to sign in or sign up
#     [ ] The sign in page requests a username or email and a password
#     [ ] If I enter all valid information, I am sent to the "Report your Catch" form
#
#   Unhappy Path:
#     [ ] If I did not provide valid credentials, I am shown the appropriate error message, and I am still at my form that is pre-filled with what I have already tried to fill out

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
