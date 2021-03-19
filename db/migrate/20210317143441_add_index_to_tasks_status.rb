class AddIndexToTasksStatus < ActiveRecord::Migration[5.2]
# 検索インデックス
  def change
    add_index :tasks, :status
  end
end
