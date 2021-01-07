require "rails_helper"

RSpec.describe User, type: :model do
  context "必要事項すべて記入している" do
    let(:user) { build(:user) }
    it "ユーザー作成は成功" do
      expect(user).to be_valid
    end
  end

  context "name のみ記入している" do
    let(:user) { build(:user, email: nil, password: nil) }
    it "エラーが発生する" do
      expect(user).to be_invalid
    end
  end

  context "email が未記入" do
    let(:user) { build(:user, email: nil) }
    it "エラーが発生する" do
      expect(user).to be_invalid
    end
  end

  context "password が未記入" do
    let(:user) { build(:user, password: nil) }
    it "エラーが発生する" do
      expect(user).to be_valid
    end
  end
end
