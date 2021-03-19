require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  before do
     @task = FactoryBot.create(:task)
     @second_task = FactoryBot.create(:second_task)

   end
  describe '検索機能' do
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。
        # メソッド名は任意で構わない。
        expect(Task.search_title('task1').count).to eq 1
        # expect([, , ]).to include

      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        expect(Task.search_status('完了').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        expect(Task.search_title('task').search_status('完了').count).to eq 1
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
         task = Task.new(title: '成功テスト', content: '成功', deadline: '2021/12/16', status: '未着手', priority: '中' )
         expect(task).to be_valid
       end
     end
   end
end
