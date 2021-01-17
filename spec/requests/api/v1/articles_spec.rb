require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }
    before { create_list(:article, 3) }
    it "記事一覧を取得する" do
      subject
      expect(response).to have_http_status(:ok)
    end
  end


  describe "GET /articles/:id" do
    subject { get (api_v1_article_path(article_id)) }
    #正常系
    context "指定した id のユーザーが存在するとき" do
      # let!(:article){ get(api_v1_articles_path(:article_id)) }
      # let!(:article){ create_list(:article, 3) }
      let(:article) { create(:article)}
      let(:article_id){ article.id }

      fit "対象の id 記事を取得する" do
        subject
        res = JSON.parse(response.body)
        expect(res[:id]).to eq article.id
        binding.pry
      
        expect(response).to have_http_status(:ok)
      end
    end

    #異常系
    context "指定した id の記事が見つからない" do
      it "ユーザーが見つからない" do

      end
    end
  end
end
