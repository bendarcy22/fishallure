require 'rails_helper'

RSpec.describe FishType, type: :model do
  it { is_expected.to have_valid(:name).when('Striped Bass') }
  it { is_expected.to have_valid(:user_id).when('1') }
  it { is_expected.to_not have_valid(:name).when(nil, '') }
  it { is_expected.to_not have_valid(:user_id).when(nil, '') }
end
