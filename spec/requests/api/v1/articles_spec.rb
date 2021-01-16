require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }
    before { create_list(:article, 3) }

    #記事一覧を更新順に並べる
    # let(:article) { create(:article, :updated_at) }
    fit "記事一覧を取得する" do
      subject
      res = JSON.parse(response.body)
      #このテスト(expect)で何を確認すべきか
      #記事の一覧が更新順にかえって来ることを確認する
      expect(response).to have_http_status(:ok)
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      binding.pry
    end
  end
end
