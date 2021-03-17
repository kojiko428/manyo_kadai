require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # 【step3】コメントアウト
  # let!(:task) { FactoryBot.create(:task, title: 'task') }

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
      fill_in 'task_deadline', with: '2021/12/16'

      click_on  'Create'
      visit tasks_path

      expect(page).to have_content 'task1'
      expect(page).to have_content 'content1'
      expect(page).to have_content '12/16'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
          it '終了期限の降順で表示される' do

            click_on '終了期限でソートする'
            # 条件に合致した要素の配列を取得
            task_list = all('.deadline_row')

            expect(task_list[0]).to have_content '12/17'
            expect(task_list[1]).to have_content '12/16'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         @task = FactoryBot.create(:task, title: 'task')
         visit task_path(@task)
         expect(page).to have_content 'task'

       end
     end
  end
end
