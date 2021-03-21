require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  before do
        @user = FactoryBot.create(:user)
        @admin_user = FactoryBot.create(:admin_user)
  end
  before do
        @task1 = FactoryBot.create(:task, title: 'task',user: @user)
        @task2 = FactoryBot.create(:second_task, title:'task2',user: @user)
        @task3 = FactoryBot.create(:third_task,title: 'task3',user: @user)
  end


 # ステップ4
   describe '検索機能' do
     context 'scopeメソッドでタイトルのあいまい検索をした場合' do
       it "検索キーワードを含むタスクが絞り込まれる" do
         # title_seachはscopeで提示したタイトル検索用メソッドである。
         # メソッド名は任意で構わない。
         expect(Task.search_title('task1')).to include(@task1)
       end
     end
     context 'scopeメソッドでステータス検索をした場合' do
       it "ステータスに完全一致するタスクが絞り込まれる" do
         # ここに内容を記載する
         expect(Task.search_status('完了').count).to include(@task1)
       end
     end
     context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
       it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
         # ここに内容を記載する
         expect(Task.search_title('task3').search_status('着手中').to include(@task3)
       end
     end
   end
   describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(title: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(title: '失敗テスト', content: '')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          task = Task.new(title: '成功テスト', content: '成功', deadline: '2021/12/16', status: '未着手', priority: '中', user_id: 1 )
          expect(task).to be_valid
        end
      end
    end
end
