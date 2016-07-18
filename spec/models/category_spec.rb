require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_valid(:name).when('Jig') }
  it { is_expected.to_not have_valid(:name).when(nil) }
end
