# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text(65535)
#  status     :string(255)      default(NULL)
#  title      :string(255)
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

  context "本文とタイトルが記入されている" do
    let(:article) { build(:article) }
    it "下書きが作成される" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
    end
  end

  context "ステータスが下書きのとき" do
    let(:article) { build(:article, :draft) }

    it "下書きが保存される" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
    end
  end

  context "ステータスが公開のとき" do
    let(:article) { build(:article, :published) }
    it "記事が公開することが出来る" do
      expect(article).to be_valid
      expect(article.status).to eq "published"
    end
  end
end
