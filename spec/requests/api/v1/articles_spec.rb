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
    subject { get(api_v1_article_path(article_id)) }
    # 正常系

    context "指定した id のユーザーが存在するとき" do
      let(:article) { create(:article) }
      let(:article_id) { article.id }

      it "任意の記事の値が取得出来る" do
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to be_present

        expect(response).to have_http_status(:ok)
      end
    end

    # 異常系
    context "指定した id の記事が見つからない" do
      let(:article_id) { 999999 }
      it "ユーザー id が見つからない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "P0ST/articles" do
    subject { post(api_v1_articles_path, params: params) }

    context "userテーブルの一番初めのユーザー" do
      let(:params) { { article: attributes_for(:article) } }
      let(:current_user) { create(:user)}

      before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

      fit "記事のレコードが1つ作成される"do
        expect { subject }.to change { Article.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:article][:title]
        expect(res["body"]).to eq params[:article][:body]
        expect(response).to have_http_status(200)
      end
    end
  end
end
