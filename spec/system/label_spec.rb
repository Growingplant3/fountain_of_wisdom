require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let(:general_user) { FactoryBot.create(:general_user) }
  let(:label) { FactoryBot.create(:label, user: general_user) }
  let(:rare_label) { FactoryBot.create(:rare_label, user: general_user) }
  let(:common_label) { FactoryBot.create(:common_label, user: general_user) }
  before {
    general_user
    visit new_session_path
    fill_in "session_email", with: "general@example.com"
    fill_in "session_password", with: "password"
    find("#create_tag").click
  }
  describe '新規作成機能' do
    context 'ラベルを新規作成した場合' do
      it '作成したラベルが表示される' do
        visit new_label_path
        fill_in "label_name", with: "正しいラベル"
        click_on "登録する"
        expect(page.text).to include "ラベル一覧を確認する" && "正しいラベル"
      end
    end
  end

  describe '一覧表示' do
    before {
    label
    rare_label
    common_label
    visit labels_path
    }
    context '一覧表示画面に遷移した場合' do
      it '作成済みラベル一覧が表示される' do
        expect(page.text).to include "正しいラベル" && "珍しいラベル" && "よくあるラベル"
      end

      it '作成済みラベルが編集できる' do
        click_on "編集する", match: :first
        fill_in "label_name", with: ""
        fill_in "label_name", with: "変更したラベル"
        click_on "更新する"
        expect(page.text).to include "変更したラベル"
      end

      it '作成済みラベルが削除できる' do
        page.accept_confirm do
          click_on "削除する", match: :first
        end
        expect(page.text).not_to include "正しいラベル"
      end
    end
  end
end
