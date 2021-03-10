class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
    # ユニーク制約 同一のメールアドレス登録できない
    add_index :users, :email, unique: true
  end
end
