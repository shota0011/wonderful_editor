require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }

    let!(:article1) { create(:article, :published, updated_at: 1.days.ago) }
    let!(:article2) { create(:article, :published, updated_at: 2.days.ago) }
    let!(:article3) { create(:article, :published) }

    before { create(:article, :draft) }

    it "公開された記事一覧を取得する" do
      subject
      res = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(res.length).to eq 3
      expect(res.map {|d| d["id"] }).to eq [article3.id, article1.id, article2.id]
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
    end
  end

  describe "GET /articles/:id" do
    subject { get(api_v1_article_path(article_id)) }
    # 正常系

    context "指定した id のユーザーが存在するとき" do
      let(:article) { create(:article, :published) }
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
    context "指定した id の記事が存在しないとき" do
      let(:article_id) { 999999 }
      it "ユーザー id が見つからない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "P0ST/articles" do
    subject { post(api_v1_articles_path, params: params, headers: headers) }

    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context "公開された記事を作成するとき" do
      let(:params) { { article: attributes_for(:article, :published) } }

      it "記事のレコードが作成される" do
        expect { subject }.to change { Article.where(user_id: current_user.id).count }.by(1)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:article][:title]
        expect(res["body"]).to eq params[:article][:body]
        expect(response).to have_http_status(:ok)
      end
    end

    context "下書きを指定して作成するとき" do
      let(:params) { { article: attributes_for(:article, :draft) } }

      it "下書きが作成される" do
        subject
        res = JSON.parse(response.body)
        expect(res["status"]).to eq "draft"
      end
    end
  end

  describe "PATCH /api/v1/articles/:id" do
    subject { patch(api_v1_article_path(article.id), params: params, headers: headers) }

    let(:params) { { article: attributes_for(:article) } }
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context "自分の記事のレコードを更新しようとするとき" do
      let(:article) { create(:article, user: current_user) }

      it "更新した値が書き換えられている" do
        expect { subject }.to change { article.reload.title }.from(article.title).to(params[:article][:title]) &
                              change { article.reload.body }.from(article.body).to(params[:article][:body])
        expect(response).to have_http_status(:ok)
      end
    end

    context "自分意外のレコードを更新しようとするとき" do
      let(:other_user) { create(:user) }
      let!(:article) { create(:article, user: other_user) }

      it "エラーになる" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound) &
                              change { Article.count }.by(0)
      end
    end
  end

  describe "DELETE /api/v1/article/:id" do
    subject { delete(api_v1_article_path(article_id), headers: headers) }

    let(:current_user) { create(:user) }
    let(:article_id) { article.id }
    let(:headers) { current_user.create_new_auth_token }

    context "自分の記事を削除しようとするとき" do
      let!(:article) { create(:article, user: current_user) }

      it "その記事が削除される" do
        expect { subject }.to change { Article.count }.by(-1)
      end
    end

    context "他人の記事を削除しようとするとき" do
      let(:other_user) { create(:user) }
      let!(:article) { create(:article, user: other_user) }

      it "エラーになる" do
        expect { subject }.to raise_error { ActiveRecord::RecordNotFound } &
                              change { Article.count }.by(0)
      end
    end
  end
end
