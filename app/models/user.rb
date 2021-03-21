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
  # has_many :favorites, dependent: :destroy

# 削除直前
  before_destroy :check_admin_deatroy
# 更新直前
  before_update :check_admin_update

  private
    def check_admin_deatroy
       if User.where(admin: true).count <= 1 && self.admin == true
       errors.add(:admin,"は、最低でも１人は必要です。")
       throw(:abort)
       end
    end

    def check_admin_update
      if User.where(admin: true).count <= 1 && self.admin == true
         errors.add(:admin,"は、最低でも１人は必要です。")
      throw(:abort)
      end
    end

end
