require "rails_helper"

RSpec.describe "Api/V1::Auth::Registrations", type: :request do
  describe "POST /v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }
    #正常系
    context "ユーザーの情報がすべて入力されている" do
      let(:params) { attributes_for(:user) }
      it "新規登録が出来る" do
        expect{ subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
      end

      fit "ヘッダーの情報が取得出来ている" do
        subject
        header = response.header
        binding.pry
        subject
        expect(header["access-token"]).to be_present
        expect(header["token-type"]).to be_present
        expect(header["client"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
      end
    end

    #異常系
    context "nameが存在しないとき" do
      let(:params) { name :nil }
      # res = JSON.parse(response.body)
      it "エラーになる" do
        binding.pry
        subject
        # expect { subject }.to raise_error ()
      end
    end

    context "emailが存在しないとき" do

    end
    context "passwordが存在しないとき" do

    end
  end
end
