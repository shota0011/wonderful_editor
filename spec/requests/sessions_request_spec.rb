require "rails_helper"

RSpec.describe "api/v1::auth::Sessions", type: :request do
  describe "name,email,passwordのすべてが入力されている" do
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
  end
end
