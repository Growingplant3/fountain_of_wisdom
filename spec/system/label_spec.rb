require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let(:general_user) { FactoryBot.create(:general_user) }
  let(:label) { FactoryBot.create(:label, user: general_user) }
  describe '新規作成機能' do
    before {
      general_user
      visit new_session_path
      fill_in "session_email", with: "general@example.com"
      fill_in "session_password", with: "password"
      find("#create_tag").click
    }
    context 'ラベルを新規作成した場合' do
      it '作成したラベルが表示される' do
        visit new_label_path
        fill_in "label_name", with: "正しいラベル"
        click_on "登録する"
        expect(page.text).to include "ラベル一覧を確認する" && "正しいラベル"
      end
    end
  end
end
