require 'coveralls'
Coveralls.wear!('rails')

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def log_in_user
  visit new_user_registration_path
  fill_in 'Email', with: 'catchallthefish@gmail.com'
  fill_in 'Username', with: 'catchallthefish'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  click_on 'Sign up'
end

def report_a_catch
  log_in_user
  click_link "Report your Catch"
  expect(page).to have_content "Report what you caught here!"
  select "Striped Bass", from: "Fish"
  select "BestLure", from: "Lure"
  fill_in "Latitude", with: "0"
  fill_in "Longitude", with: "0"
  fill_in "Caught at", with: "2016/01/01"
  attach_file "Add a picture of your catch!", "#{Rails.root}/spec/support/images/photo.png"
  click_button("Report it!")
end

def sign_out
  click_on "Sign Out"
end

def sign_in_as_dummy
  visit new_user_registration_path
  fill_in 'Email', with: 'imadummyaccount@gmail.com'
  fill_in 'Username', with: 'imadummyaccount'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  click_on 'Sign up'
end
