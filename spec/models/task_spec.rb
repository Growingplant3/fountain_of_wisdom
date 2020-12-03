require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスク名が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: nil, detail: "失敗テスト", priority: 0, situation: 0, deadline: DateTime.tomorrow)
        expect(task).not_to be_valid
      end
    end
    context 'タスク詳細が空の場合' do
      it 'バリデーションにひっかからない' do
        task = Task.new(name: "成功テスト", detail: nil, priority: 0, situation: 0, deadline: DateTime.tomorrow)
        expect(task).to be_valid
      end
    end
    context 'タスクの重要度が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: "新年会", detail: nil, priority: nil, situation: 0, deadline: DateTime.tomorrow)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの進行状況が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: "新年会", detail: nil, priority: 0, situation: nil, deadline: DateTime.tomorrow)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの終了期限が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: "新年会", detail: nil, priority: 0, situation: 0, deadline: nil)
        expect(task).not_to be_valid
      end
    end
    context 'タスク名とタスクの重要度とタスクの進行状況とタスクの終了期限が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: "結婚式", detail: nil, priority: 3, situation: 2, deadline: DateTime.tomorrow)
        expect(task).to be_valid
      end
    end
  end
end