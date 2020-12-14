require 'rails_helper'

RSpec.describe Label, type: :model do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  describe 'バリデーションのテスト' do
    context 'ラベル名が空の場合' do
      it 'バリデーションにひっかかる' do
        label = admin_user.labels.new(name: nil)
        expect(label).not_to be_valid
      end
    end

    context 'ラベル名が空ではない場合' do
      it 'バリデーションに引っかからない' do
        label = admin_user.labels.new(name: "正しいラベル")
        expect(label).to be_valid
      end
    end
  end
end
