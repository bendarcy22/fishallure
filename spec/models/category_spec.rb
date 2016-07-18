require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_valid(:type).when('Jig') }
  it { is_expected.to_not have_valid(:type).when(nil) }
end
