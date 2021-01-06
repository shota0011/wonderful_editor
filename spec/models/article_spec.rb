# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
require "rails_helper"

RSpec.describe Article, type: :model do
  context "タイトルと本文が入力されているとき" do
    let(:article) { build(:article) }
    it "記事の作成が出来る" do
      expect(article).to be_valid
    end
  end

  context "タイトルが未記入" do
    let(:article) { build(:article, title: nil) }
    it "エラーが発生" do
      expect(article).to be_invalid
    end
  end

  context "本文が未記入" do
    let(:article) { build(:article, body: nil) }
    it "エラーが発生" do
      expect(article).to be_valid
    end
  end
end
