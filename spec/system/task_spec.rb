require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task') }

  before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      visit tasks_path
    end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'task_title', with: 'task1'
      fill_in 'task_content', with: 'content1'
      # 年の部分が６桁分入る
      fill_in  'deadline', with: DateTime.now.beginning_of_day + 1.day

      click_on  'Create'

      expect(page).to have_content 'task1'
      expect(page).to have_content 'content1'
      expect(page).to have_content '03/17'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        # タスク一覧ページに遷移
        #before doメソッドにて省略:visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
        # テスト内容を追加で記載する
    context 'タスクが作成日時の降順に並んでいる場合' do
          # it '新しいタスクが一番上に表示される' do
          it '終了期限の降順で表示される' do

            click_on '終了期限でソートする'

            task_list = all('.deadline_row')
            expect(task_list[0]).to have_content '03/16'
            expect(task_list[1]).to have_content '03/17'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         @task = FactoryBot.create(:task, title: 'task')
         #ルート task_path(task.id)
         visit task_path(@task)
         expect(page).to have_content 'task'

       end
     end
  end
end
