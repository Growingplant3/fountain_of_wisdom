require 'rails_helper'

RSpec.describe 'ユーザーモデル機能', type: :model do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:general_user) { FactoryBot.create(:general_user) }
  describe 'バリデーションのテスト' do
    context 'アカウント名が空の場合' do
      it 'バリデーションにひっかかる' do
        admin_user.name = nil
        expect(admin_user).not_to be_valid
      end
    end

    context 'アカウント名が20文字を超える場合' do
      it 'バリデーションにひっかかる' do
        admin_user.name = "a" * 21
        expect(admin_user).not_to be_valid
      end
    end

    context 'アカウント名が重複している場合' do
      it 'バリデーションにひっかかる' do
        admin_user
        general_user.name = "Administrator"
        expect(general_user).not_to be_valid
      end
    end

    context 'メールアドレスが空の場合' do
      it 'バリデーションにひっかかる' do
        admin_user.email = ""
        expect(admin_user).not_to be_valid
      end
    end

    context 'メールアドレスが重複している場合' do
      it 'バリデーションにひっかかる' do
        admin_user
        general_user.email = "admin@example.com"
        expect(general_user).not_to be_valid
      end
    end

    context 'メールアドレスが50文字を超える場合' do
      it 'バリデーションにひっかかる' do
        admin_user.email = "a" * 51
        expect(admin_user).not_to be_valid
      end
    end

    context 'パスワードが空の場合' do
      it 'バリデーションにひっかかる' do
        admin_user.password = nil
        expect(admin_user).not_to be_valid
      end
    end

    context 'パスワードが8文字未満の場合' do
      it 'バリデーションにひっかかる' do
        admin_user.password = "a" * 7
        expect(admin_user).not_to be_valid
      end
    end

    context 'パスワードが16文字を超える場合' do
      it 'バリデーションにひっかかる' do
        admin_user.password = "a" * 17
        expect(admin_user).not_to be_valid
      end
    end

    context 'パスワードが16文字を超える場合' do
      it 'バリデーションにひっかかる' do
        admin_user.password = "a" * 17
        expect(admin_user).not_to be_valid
      end
    end

    context '管理者権限がある場合' do
      it 'バリデーションにひっかからない' do
        expect(admin_user).to be_valid
      end
    end

    context '管理者権限がない場合' do
      it 'バリデーションにひっかからない' do
        expect(general_user).to be_valid
      end
    end

    context 'アカウント名とメールアドレスとパスワードと管理者権限が記載されている場合' do
      it 'バリデーションにひっかからない' do
        expect(admin_user).to be_valid
      end
    end
  end
end
