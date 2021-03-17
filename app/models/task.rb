class Task < ApplicationRecord
# 空エラーのバリデーション
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  
  enum status: { '未着手': 0, '着手中': 1, '完了': 2 }

# tasks_contoroller indexのあいまい検索のメソッド

# 【1】あいまい検索（title）＆完全一致検索（status）
  scope :search_status_and_title, ->(status,title) {
  where(status: status)and where("title like ?", "%#{title}%")
  }
# 【2】あいまい検索（title）
  scope :search_title, ->(title) {
  where("title like ?", "%#{title}%")
  }
# 【3】完全一致検索（status）
  scope :search_status, ->(status) {
  where(status: status)
  }

# アソシエーション
#   belongs_to :user
#【6】 #お気に入り
#   has_many :favorites, dependent: :destroy
#   has_many :favorite_users, through: :favorites, source: :user
end
