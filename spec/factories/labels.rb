FactoryBot.define do
  factory :label do
    name { '開発' }
  end
  factory :second_label do
    name { '運用' }
  end
  factory :third_label  do
    name { '検討課題' }
  end
end
