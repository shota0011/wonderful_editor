require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  fdescribe "GET /articles" do
    subject { get(api_v1_articles_path) }
    before { create_list(:article, 3) }

    #記事一覧を更新順に並べる
    # let(:article) { create(:article, :updated_at) }
    it "記事一覧を取得する" do
      subject
      #このテスト(expect)で何を確認すべきか
      #記事の一覧が更新順にかえって来ることを確認する
      binding.pry
      # expect(response).to have_http_status(:success)
    end
  end
end
