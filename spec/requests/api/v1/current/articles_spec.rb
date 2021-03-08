require 'rails_helper'

RSpec.describe "Api::V1::Current::Articles", type: :request do
  describe "GET /api/v1/current/articles" do
    subject { get(api_v1_current_articles_path, headers: headers) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }

    fcontext "記事が複数存在する時" do
      let!(:article1) { create(:article, :published, user: current_user, updated_at: 1.day.ago)}
      let!(:article2) { create(:article, :published, user: current_user, updated_at: 2.day.ago)}
      let!(:article3) { create(:article, :published, user: current_user)}

      before do
        create(:article, :draft, user: current_user)
        create(:article, :published)
      end

      it "公開記事を取得出来る" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq 3
        expect(res.map {|d| d["id"] }).to eq [article3.id, article1.id, article2.id]
        expect(res[0]["user"]["id"]).to eq current_user.id
        expect(res[0]["user"]["name"]).to eq current_user.name
        expect(res[0]["user"]["email"]).to eq current_user.email
      end
    end
  end
end
