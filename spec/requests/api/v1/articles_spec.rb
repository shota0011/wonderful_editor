require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }
<<<<<<< HEAD

    let(:article) { create(:article) }

    it "記事一覧を取得する" do
=======
    let(:article) { create(:article)
    fit "returns http success" do
>>>>>>> b6369dbb3d8bd6bc8061df430e4d2e8686cc16fa
      subject
      
      # get "/api/v1/articles/index"
      # expect(response).to have_http_status(:success)
    end
  end
end
