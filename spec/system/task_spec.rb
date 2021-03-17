require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '検索機能' do
  # 【step3】コメントアウト
  # let!(:task) { FactoryBot.create(:task, title: 'task') }
  before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
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
