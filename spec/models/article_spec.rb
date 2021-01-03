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
  context "本文が5000文字以内のとき" do
  end
  context "本文が5000文字以上のとき" do
  end
end
