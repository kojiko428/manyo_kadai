FactoryBot.define do
  factory :user do
    name { 'test1' }
    email { '000000@example.com' }
    password { '00000000' }
    admin { false }
  end
  factory :second_user, class: User do
    name { '管理者' }
    email { 'admin1@example.jp' }
    password { '12345678' }
    admin { true }
  end
end
