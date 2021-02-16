require "rails_helper"

RSpec.describe "Api/V1::Auth::Registrations", type: :request do
  describe "POST /v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "ユーザーの情報がすべて入力されている" do
      let(:params) { attributes_for(:user) }

      it "新規登録が出来る" do
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
      end

      it "ヘッダーの情報が取得出来ている" do
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["token-type"]).to be_present
        expect(header["client"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
      end
    end

    context "nameが存在しないとき" do
      let(:params) { attributes_for(:user, name: nil) }
      it "エラーになる" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(res["errors"]["name"]).to include "can't be blank"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "emailが存在しないとき" do
      let(:params) { attributes_for(:user, email: nil) }
      it "エラーになる" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(res["errors"]["email"]).to include "can't be blank"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "passwordが存在しないとき" do
      let(:params) { attributes_for(:user, password: nil) }
      it "エラーになる" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(res["errors"]["password"]).to include "can't be blank"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
