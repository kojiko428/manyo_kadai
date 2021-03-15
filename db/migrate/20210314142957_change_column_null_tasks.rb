class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  # データベースの制約
  change_column :tasks, :title,   :string, null: false
  change_column :tasks, :content, :text, null: false
end
