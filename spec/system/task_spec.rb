require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # 【step3】コメントアウト
  # let!(:task) { FactoryBot.create(:task, title: 'task') }
  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session_email', with:'000000@example.com'
    fill_in 'session_password', with:'00000000'
    click_on 'Log in'
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
    FactoryBot.create(:third_task, user: @user)
    visit tasks_path
    end
      # FactoryBot.create(:task)
      # FactoryBot.create(:second_task)
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title', with: 'task1'
        fill_in 'task_content', with: 'content1'
        fill_in 'task_deadline', with: '2021/12/16'
        select '未着手', from: 'task_status'
        select '高', from: 'task_priority'

        click_on  'Create'

        expect(page).to have_content 'task1'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # FactoryBot.create(:task, title: "task")
        # FactoryBot.create(:second_task, title: "sample")
        visit tasks_path
        expect(page).to have_content 'task3'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'task3'
      expect(task_list[1]).to have_content 'task2'
      end
    end

    context '終了期限でソートするボタンを押した場合' do
      it '終了期限の降順で表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        visit tasks_path(sort_expired: "true")
        task_list = all('.deadline_row')
        expect(task_list[0]).to have_content "12/18"
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
      expect(page).to have_content 'task3'
      end
    end
  end

      #   context '優先順位でソートするボタンを押した場合' do
      #     it '優先順位の昇順で表示される' do
      #       visit tasks_path
      #       click_on '優先順位でソートする'
      #       task_list = all('.priority_ranking')
      #       expect(task_list[0]).to have_content '高'
      #     end
      #   end
      # end

describe '検索機能' do
  before do
     visit new_task_path
     fill_in 'task_title', with: 'task1'
     fill_in 'task_content', with: 'content1'
     fill_in 'task_deadline', with: '2021/12/16'
     select '未着手', from: 'task_status'
     select '中', from: 'task_priority'
     click_on  'Create'

     visit new_task_path
     fill_in 'task_title', with: 'test2'
     fill_in 'task_content', with: 'content2'
     fill_in 'task_deadline', with: '2021/12/17'
     select '未着手', from: 'task_status'
     select '高', from: 'task_priority'

     click_on  'Create'
   end

  context 'タイトルであいまい検索をした場合' do
    it "検索キーワードを含むタスクで絞り込まれる" do
      visit tasks_path
      # タスクの検索欄に検索ワードを入力する (例: task)
      # 検索ボタンを押す
      fill_in 'タイトル検索',with: 'task'
      click_on '検索'
      expect(page).to have_content 'task'
    end
  end
  context 'ステータス検索をした場合' do
    it "ステータスに完全一致するタスクが絞り込まれる" do
    # ここに実装する
    # プルダウンを選択する「select」について調べてみること
    visit tasks_path
    select '着手中',from: 'ステータス検索'
    expect(page).to have_select('ステータス検索', selected: '着手中')
    end
  end
  context 'タイトルのあいまい検索とステータス検索をした場合' do
    it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
    # ここに実装する
    visit tasks_path
    fill_in 'タイトル検索',with: 'task'
    click_on '検索'
    select '着手中',from: 'ステータス検索'
    expect(page).to have_content 'task'
    expect(page).to have_select('ステータス検索', selected: '着手中')
      end
    end
  end
end
