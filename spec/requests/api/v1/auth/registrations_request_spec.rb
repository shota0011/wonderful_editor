require "rails_helper"

RSpec.describe "Api/V1::Auth::Registrations", type: :request do
  describe "POST /v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }
    #正常系
    context "ユーザーの情報がすべて入力されている" do
      let(:params) { attributes_for(:user) }
      fit "新規登録が出来る" do
        binding.pry
        expect{ subject }.to change { User.count }.by(1)
        binding.pry
      end
    end
    #ヘッダー情報が取得できているかどうか
    contxet "" do

    end
  end
    #異常系
  #   context "nameが存在しないとき" do
  #     let(:params) { name :nil }
  #     # res = JSON.parse(response.body)
  #     it "エラーになる" do
  #       binding.pry
  #       subject
  #       # expect { subject }.to raise_error ()
  #     end
  #   end

  #   context "emailが存在しないとき" do

  #   end
  #   context "passwordが存在しないとき" do

  #   end
end
