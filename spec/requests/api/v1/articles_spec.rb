require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }
    let(:article) { create(:article) }

    fit "returns http success" do
      subject
      binding.pry
      # get "/api/v1/articles/index"
      # expect(response).to have_http_status(:success)

    end
  end
end
