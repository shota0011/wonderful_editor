require "rails_helper"

RSpec.describe "api/v1::auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    let(:user) { create(:user) }
    let(:params) { attributes_for(:user, email: user.email, password: user.password) }

    context "name,email,passwordのすべてが入力されている" do
      it "ログイン出来る" do
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(header["uid"]).to be_present
        expect(response).to have_http_status(:ok)
      end
    end
    context "emailが一致しない" do
      let(:params) { attributes_for(:user, email: "foo") }

      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(header["access-token"]).to be_blank
        expect(header["client"]).to be_blank
        expect(header["uid"]).to be_blank
      end
    end

    context "passwordが一致しない" do
      let(:params) { attributes_for(:user, password: "foo") }
      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(res["errors"]).to include "Invalid login credentials. Please try again."
        expect(header["access-token"]).to be_blank
        expect(header["client"]).to be_blank
        expect(header["uid"]).to be_blank
      end
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    subject { delete(destroy_api_v1_user_session_path, headers: headers) }

    context "ログアウトする時に必要な情報を送信したとき" do
      let(:user) { create(:user) }
      let(:headers) { user.create_new_auth_token }

      it "トークンを無くして、ログアウト出来る" do
        subject
        expect(user.reload.tokens).to be_blank
        expect(response).to have_http_status(:ok)
      end
    end

    context "誤った情報を送信した時" do
      let(:user) { create(:user) }
      let(:token) { user.create_new_auth_token }
      let(:headers) { { "accsess-token" => "", "token-type" => "", "client" => "", "expiry" => "", "uid" => "" } }

      it "ログアウト出来ない" do
        subject
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(res["errors"]).to include "User was not found or was not logged in."
      end
    end
  end
end
