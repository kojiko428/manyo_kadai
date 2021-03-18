class Task < ApplicationRecord
# 空エラーのバリデーション
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
# 登録したらエラー表示追加する

  enum status: { '未着手': 0, '着手中': 1, '完了': 2 }
# tasks_contoroller indexのあいまい検索のメソッド

# step3【1】あいまい検索（title）＆完全一致検索（status）
# error:検索時にあいまい検索ができない！ andで結ばす、結合した
  scope :search_title_and_status, ->(title , status) {
  where("title like ?", "%#{title}%").where(status: status)
  }
# 【2】あいまい検索（title）
  scope :search_title, ->(title) {
  where("title like ?", "%#{title}%")
  }
# 【3】完全一致検索（status）
  scope :search_status, ->(status) {
  where(status: status)
  }

# step3 優先順位の受け取る値紐づけ 実際に表示される
  enum priority: { '高': 0, '中': 1, '低': 2 }

#×【4】完全一致検索(priority)
  # scope :search_priority, ->(priority) {
  # where(priority: priority)
  # }

# アソシエーション
#   belongs_to :user
#【6】 #お気に入り
#   has_many :favorites, dependent: :destroy
#   has_many :favorite_users, through: :favorites, source: :user
end
