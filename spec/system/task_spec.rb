require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:general_user) { FactoryBot.create(:general_user) }
  let(:task) { FactoryBot.create(:task, user: general_user) }
  describe '新規作成機能' do
    before {
      general_user
      visit new_session_path
      fill_in "session_email", with: "general@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
    }
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_name", with: "正しいタスク名"
        fill_in "task_detail", with: "正しいタスク詳細"
        find("option[value='high']").select_option
        find("option[value='finished']").select_option
        fill_in "task_deadline", with: "003000-12-31T23:59"
        click_on "登録する"
        expect(page.text).to include "正しいタスク名" && "正しいタスク詳細" && "高" && "完了" && "3000年12月31日 23時59分"
      end
    end
  end

  describe '一覧表示機能' do
    before {
      general_user
      visit new_session_path
      fill_in "session_email", with: "general@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
    }
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task
        FactoryBot.create(:task, name: "正しいデータ1", user_id: general_user.id )
        FactoryBot.create(:task, name: "正しいデータ2", user_id: general_user.id )
        visit tasks_path
        task_list = all('.task_row')
        expect(page).to have_content "タスク一覧"
        expect(task_list[0].text).to include "正しいデータ2"
        expect(task_list[1].text).to include "正しいデータ1"
        expect(task_list[2].text).to include "正しいデータ0"
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      before {
        task
        FactoryBot.create(:task, name: "正しいデータ1", user_id: general_user.id )
        FactoryBot.create(:task, name: "正しいデータ2", user_id: general_user.id )
      }
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list.first.text).to include "正しいデータ2"
      end

      it '古いタスクが一番下に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list.last.text).to include "正しいデータ0"
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      before {
        FactoryBot.create(:task, name: "正しいデータ2", deadline: "(3000/01/03).to_datetime", user: general_user)
        FactoryBot.create(:task, name: "正しいデータ3", deadline: "(3000/01/04).to_datetime", user: general_user)
        task
        FactoryBot.create(:task, name: "正しいデータ1", deadline: "(3000/01/02).to_datetime", user: general_user)
      }
      it '期限の長いタスクが一番上に表示される' do
        visit tasks_path(sort_expired: "true")
        task_list = all('.task_row')
        expect(task_list.first.text).to include "3000年01月04日"
      end

      it '期限の短いタスクが一番下に表示される' do
        visit tasks_path(sort_expired: "true")
        task_list = all('.task_row')
        expect(task_list.last.text).to include "3000年01月01日"
      end
    end

    context 'タスクが優先順位の降順に並んでいる場合' do
      before {
        FactoryBot.create(:task, name: "正しいデータ2", priority: 1, user: general_user)
        FactoryBot.create(:task, name: "正しいデータ3", priority: 2, user: general_user)
        task
        FactoryBot.create(:task, name: "正しいデータ1", priority: 1, user: general_user)
      }

      it '優先度の高いタスクが一番上に表示される' do
        visit tasks_path(sort_importance: "true")
        task_list = all('.task_row')
        expect(task_list.first.text).to include "高"
      end

      it '優先度の低いタスクが一番下に表示される' do
        visit tasks_path(sort_importance: "true")
        task_list = all('.task_row')
        expect(task_list.last.text).to include "低"
      end
    end

  #   context '条件検索をした場合' do
  #     before {
  #       task
  #       FactoryBot.create(:task, name: "正しいデータ1", situation: 1)
  #       FactoryBot.create(:task, name: "正しい旅行0", situation: 1)
  #       FactoryBot.create(:task, name: "正しい旅行1", situation: 2)
  #     }
  #     subject {
  #       click_on "検索する"
  #       task_list = all('.task_row')
  #       task_list.length
  #     }

  #     it 'タスク名で検索ができる' do
  #       visit tasks_path
  #       fill_in "task_name", with: "正しいデータ0"
  #       is_expected.to eq 1
  #     end

  #     it '進行状況で検索ができる' do
  #       visit tasks_path
  #       find("option[value='finished']").select_option
  #       is_expected.to eq 1
  #     end

  #     it 'タスク名と進行状況で検索ができる' do
  #       visit tasks_path
  #       fill_in "task_name", with: "正しい旅行"
  #       find("option[value='started']").select_option
  #       is_expected.to eq 1
  #     end
  #   end
  end

  # describe '詳細表示機能' do
  #   context '任意のタスク詳細画面に遷移した場合' do
  #     it '該当タスクの内容が表示される' do
  #       visit task_path(task)
  #       expect(page).to have_content "タスクの詳細" && "正しいデータ0"
  #     end
  #   end
  # end
end
