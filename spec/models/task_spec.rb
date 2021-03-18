require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    # FactoryBot.create(:task)
    # FactoryBot.create(:second_task)
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。
        # メソッド名は任意で構わない。
        task1 = Task.create!(title: 'task',content:'content',deadline: '2020-12-16',status: '完了', priority: '高')
        tasks = Task.search_title('task')
        expect(tasks).to include task1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        task1 = Task.create!(title: 'task',content:'content',deadline: '2020-12-16',status: '完了', priority: '高')
        tasks = Task.search_status('完了')
        expect(tasks).to include task1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        task1 = Task.create!(title: 'task',content:'content',deadline: '2020-12-16',status: '完了', priority: '高')
        tasks = Task.search_title('task')
        expect(tasks).to include task1
        task1 = Task.create!(title: 'task',content:'content',deadline: '2020-12-16',status: '完了', priority: '高')
        tasks = Task.search_status('完了')
        expect(tasks).to include task1
      end
    end
  end
end
