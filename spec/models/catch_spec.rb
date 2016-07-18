require 'rails_helper'

RSpec.describe Catch, type: :model do
  it { is_expected.to have_valid(:lure_id).when('1') }
  it { is_expected.to have_valid(:fish_type_id).when('1') }
  it { is_expected.to have_valid(:user_id).when('1') }
  it { is_expected.to have_valid(:zipcode).when('12345') }
  it { is_expected.to_not have_valid(:lure_id).when('', nil) }
  it { is_expected.to_not have_valid(:fish_type_id).when('', nil) }
  it { is_expected.to_not have_valid(:user_id).when('', nil) }
  it { is_expected.to_not have_valid(:zipcode).when(nil, '', '0987654', 'letters') }
end
