# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text(65535)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  has_many :article_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
end
