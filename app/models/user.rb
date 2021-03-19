class User < ApplicationRecord
# 登録パスワードのバリデーション
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
# アソシエーション
  has_many :tasks, dependent: :destroy
#お気に入り機能
  has_many :favorites, dependent: :destroy
end
