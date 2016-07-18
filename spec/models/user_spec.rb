require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_valid(:username).when('catchallthefish') }
  it { is_expected.to have_valid(:email).when('catchallthefish@gmail.com') }
  it { is_expected.to_not have_valid(:username).when(nil) }
  it { is_expected.to_not have_valid(:email).when(nil) }
end
