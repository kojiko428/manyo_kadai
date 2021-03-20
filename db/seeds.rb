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

# 管理者権限をもつユーザー rails db:seedでerror中
User.create!(username:  "管理者",
             email: "admin@example.jp",
             password:  "123456789",
             password_confirmation: "123456789",
             admin: true)

# username:  "管理者",
# email: "admin@example.jp",
# password:  "12345678",
# password_confirmation: "12345678",
