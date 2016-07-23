source 'https://rubygems.org/'
ruby '2.2.3'

gem 'rails', '4.2.5'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'foundation-rails'
gem 'devise'
gem 'time_splitter'
gem 'carrierwave'
gem 'mini_magick'
gem "fog-aws"

group :development, :test do
  gem 'capybara'
  gem 'orderly'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 3.0'
  gem 'pry-rails'
  gem 'shoulda-matchers', '~> 3.1', require: false
  gem 'valid_attribute'
  gem "dotenv-rails"
end

group :test do
  gem 'launchy', require: false
  gem 'coveralls', require: false

end

group :production do
  gem 'rails_12factor'
end
