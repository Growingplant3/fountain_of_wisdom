require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let(:general_user) { FactoryBot.create(:general_user) }
  let(:another_user) { FactoryBot.create(:another_user) }
  describe 'サインアップ機能' do
    it '必要項目を満たせばサインアップできる' do
      visit new_user_path
      fill_in "user_name", with: "correct_user_name"
      fill_in "user_email", with: "correct_user_email@example.com"
      fill_in "user_password", with: "correct@password"
      fill_in "user_password_confirmation", with: "correct@password"
      click_on "アカウントを新規作成する"
      expect(page.text).to include "アカウントを作成後、ログインしました。"
    end
  end

  describe 'セッション機能' do
    it '正しいメールアドレスとパスワードを入力すればログインできる' do
      general_user
      visit new_session_path
      fill_in "session_email", with: "general@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
      expect(page.text).to include "ログインに成功しました。"
    end

    it 'ログインしていないユーザーはタスク一覧に遷移できない' do
      visit tasks_path
      expect(page.text).to include "ログインする必要があります"
    end

    it 'ログインしていても他人のページには遷移できない' do
      general_user
      visit new_session_path
      fill_in "session_email", with: "general@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
      another_user
      visit user_path(another_user)
      expect(page.text).to include "他人のデータを扱うことはできません"
    end
  end

  describe 'ユーザー情報確認機能'do
    it 'ログイン後にはアカウント情報確認ページに移行する' do
      general_user
      visit new_session_path
      fill_in "session_email", with: "general@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
      expect(page.text).to include "アカウント情報確認"
    end
  end

  describe 'アカウント削除機能' do
    before {
      general_user
      visit new_session_path
      fill_in "session_email", with: "general@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
    }
    it 'アカウントを削除するボタンを押せばアカウントを削除できる' do
      page.accept_confirm do
        click_on "アカウントを削除する"
      end
      expect(page.text).to include "アカウントを削除しました。"
    end
  end
    
  describe 'アカウント編集機能' do
    before {
      general_user
      visit new_session_path
      fill_in "session_email", with: "general@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
    }
    it 'アカウントを編集するボタンを押せばアカウントを編集できる' do
      click_on "アカウントを編集する"
      fill_in "user_name", with: ""
      fill_in "user_name", with: "edit_user_name"
      fill_in "user_email", with: ""
      fill_in "user_email", with: "edit_user@gmail.com"
      # fill_in "user[password]", with: "password"
      # fill_in "user[password_confirmation]", with: "password"
      save_and_open_page
      click_on "アカウントを編集する"
      save_and_open_page
      expect(page.text).to include "アカウントの編集に成功しました。"
    end
  end
  
end