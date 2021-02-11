# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  image                  :string(255)
#  name                   :string(255)
#  provider               :string(255)      default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  tokens                 :json
#  uid                    :string(255)      default(""), not null
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
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
      expect(user).to be_invalid
    end
  end
end
