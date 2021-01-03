require "rails_helper"

RSpec.describe User, type: :model do
  context "name が指定しているとき" do
    it "ユーザーが作られる" do
      user = User.new(name: "foo", email: "foo@example.com", password: "foo123456")
      expect(user).to be_valid
    end
  end

  context "name が指定していないとき" do
    it "ユーザー作成が失敗する" do
      user = User.new(email: "foo@example.com", password: "foo123456")
      expect(user).to be_invalid
    end
  end

  context "まだ同じ名前の name が存在しないとき" do
    it "ユーザーが作られる" do
    end
  end

  context "すでに同じ名前の name が存在しているとき" do
    it "ユーザー作成に失敗する" do
    end
  end
end
