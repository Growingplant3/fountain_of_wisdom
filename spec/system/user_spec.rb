require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let(:general_user) { FactoryBot.create(:general_user) }
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

  describe 'ログイン機能' do
    it '正しいメールアドレスとパスワードを入力すればログインできる' do
      general_user
      visit new_session_path
      fill_in "session_email", with: "general@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
      expect(page.text).to include "ログインに成功しました。"
    end
  end

  # describe 'アカウント削除機能' do
  #   # before {
  #   #   general_user
  #   #   visit new_session_path
  #   #   fill_in "session_email", with: "general@example.com"
  #   #   fill_in "session_password", with: "password"
  #   #   click_on "ログインする", match: :first
  #   # }
  #   it 'アカウントを削除するボタンを押せばアカウントを削除できる' do
  #     # visit user_path(general_user)
  #     general_user
  #     visit new_session_path
  #     binding.pry
  #     fill_in "session_email", with: "general@example.com"
  #     fill_in "session_password", with: "password"
  #     click_on "ログインする", match: :last
  #     binding.pry
  #     page.accept_confirm do
  #       click_on "アカウントを削除する"
  #     end
  #     expect(page.text).to include "アカウントを削除しました。"
  #   end
  # end
    
  # describe 'アカウント削除機能' do
  #   before {
  #     visit new_user_path
  #     fill_in "user_name", with: "correct_user_name"
  #     fill_in "user_email", with: "correct_user_email@example.com"
  #     fill_in "user_password", with: "correct@password"
  #     fill_in "user_password_confirmation", with: "correct@password"
  #     click_on "アカウントを新規作成する"
  #   }
  #   it 'アカウントを編集するボタンを押せばアカウントを編集できる' do
  #     click_on "アカウントを編集する"
  #     fill_in "user_name", with: "edit_user_name"
  #     fill_in "user"
  #   end
  # end
end