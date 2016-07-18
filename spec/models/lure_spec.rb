require 'rails_helper'

RSpec.describe Lure, type: :model do
  it { is_expected.to have_valid(:name).when('Slug-Go') }
  it { is_expected.to have_valid(:manufacturer).when('Lunker-City') }
  it { is_expected.to have_valid(:user_id).when('1') }
  it { is_expected.to have_valid(:category_id).when('1') }
  it { is_expected.to_not have_valid(:name).when(nil) }
  it { is_expected.to_not have_valid(:manufacturer).when(nil) }
  it { is_expected.to_not have_valid(:user_id).when('') }
  it { is_expected.to_not have_valid(:category_id).when('') }
end
