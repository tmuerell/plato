require 'rails_helper'

RSpec.describe "Imports", type: :request do
  describe "GET /ticket" do
    it "returns http success" do
      get "/import/ticket"
      expect(response).to have_http_status(:success)
    end
  end

end
