# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'task1' }
    content { 'content1' }
    deadline { '2021/12/16' }
    status { '完了'}
    priority{ '低' }
  # アソシエーション
    association :user
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'task2' }
    content { 'content2' }
    deadline { '2021/12/17'  }
    status { '未着手'}
    priority{ '高' }
    association :user
  end

  factory :third_task, class: Task do
    title { 'task3' }
    content { 'content3' }
    deadline { '2021/12/18'  }
    status { '着手中'}
    priority{ '中' }
    association :user
  end
end
