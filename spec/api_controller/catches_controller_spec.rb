require 'rails_helper'

RSpec.describe Api::CatchesController, type: :controller do
  describe "GET index" do
    it "gets all catches" do
      catches = create_list(:catch, 5)
      get :index, format: :json
      json = JSON.parse(response.body)
      ids = json["catches"].map { |c| c["id"] }
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
      expect(ids).to match_array(catches.map(&:id))
    end
  end
  describe "GET personal" do
    it "gets all catches" do
      user = FactoryGirl.create(:user)
      fish = FactoryGirl.create(:fish_type)
      lure = FactoryGirl.create(:lure)
      catch_1 = FactoryGirl.create(:catch, user: user, fish_type: fish, lure: lure)
      catch_2 = FactoryGirl.create(:catch)
      sign_in user
      get :personal, format: :json
      json = JSON.parse(response.body)
      ids = json["catches"].map { |c| c["id"] }
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
      expect(ids.count).to be 1
      expect(json["catches"][0]["id"]).to eq(catch_1.id)
      expect(json["catches"][0]["user_id"]).to eq(user.id)
    end
  end
end
