require 'rails_helper'

RSpec.describe Catch, type: :model do
  it { is_expected.to have_valid(:lure_id).when('1') }
  it { is_expected.to have_valid(:fish_type_id).when('1') }
  it { is_expected.to have_valid(:user_id).when('1') }
  it { is_expected.to have_valid(:latitude).when(0) }
  it { is_expected.to have_valid(:longitude).when(0) }
  it { is_expected.to have_valid(:caught_at).when('2000-10-10') }
  it { is_expected.to_not have_valid(:lure_id).when('', nil) }
  it { is_expected.to_not have_valid(:fish_type_id).when('', nil) }
  it { is_expected.to_not have_valid(:user_id).when('', nil) }
  it { is_expected.to_not have_valid(:latitude).when(nil,'letters') }
  it { is_expected.to_not have_valid(:longitude).when(nil,'letters') }
end
