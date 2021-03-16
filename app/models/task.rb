class Task < ApplicationRecord
# 空エラーのバリデーション
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
# アソシエーション
#   belongs_to :user
#【6】 #お気に入り
#   has_many :favorites, dependent: :destroy
#   has_many :favorite_users, through: :favorites, source: :user
end
