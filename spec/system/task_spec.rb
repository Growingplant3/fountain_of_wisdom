require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:task) { FactoryBot.create(:task) }
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_name", with: "忘年会"
        fill_in "task_detail", with: "今年最後の大宴会"
        fill_in "task_deadline", with: "#{DateTime.now + 1.day}"
        click_on "登録する"
        expect(page).to have_content "今年最後の大宴会" && "忘年会"
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content "タスク一覧"
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task0 = task
        task1 = FactoryBot.create(:task, name: "正しいデータ10001")
        task2 = FactoryBot.create(:task, name: "正しいデータ10002")
        visit tasks_path
        task_first = first('.task_row')
        expect(task_first.text.slice(5..15)).to eq "正しいデータ10002"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task)
        expect(page).to have_content "タスクの詳細"
      end
    end
  end
end
