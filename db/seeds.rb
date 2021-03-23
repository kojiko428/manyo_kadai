# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# seedにてユーザー作成：ループで３つまとめて作成
# 3.times do |index|
#   no = index + 1
#   user = User.create(
#     name:           "user_#{no}",
#     email:  "email_#{no}@example.com",
#     password:               "#{no}password#{no}",
#   )
#   user.save!
# end

# 管理者権限をもつユーザー rails db:seedでerror
# →①上記をコメントアウト、②類似ユーザーと異なるようにした→解消
# User.create!(name:  "管理者",
#              email: "admin1@example.jp",
#              password:  "12345678",
#              password_confirmation: "12345678",
#              admin: true)

# 自作した類似ユーザー情報
# username:  "管理者",
# email: "admin@example.jp",
# password:  "12345678",
# password_confirmation: "12345678",

Label.create!(
  name: '開発'
)

Label.create!(
  name: '設計'
)

Label.create!(
  name: 'テスト'
)
