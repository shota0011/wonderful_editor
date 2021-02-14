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
      let(:params) { attributes_for(:user, password: "foo")}
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
end
