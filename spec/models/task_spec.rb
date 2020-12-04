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
        task = Task.new(name: "失敗テスト", detail: nil, priority: nil, situation: 0, deadline: DateTime.tomorrow)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの進行状況が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: "失敗テスト", detail: nil, priority: 0, situation: nil, deadline: DateTime.tomorrow)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの終了期限が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: "失敗テスト", detail: nil, priority: 0, situation: 0, deadline: nil)
        expect(task).not_to be_valid
      end
    end
    context 'タスク名とタスクの重要度とタスクの進行状況とタスクの終了期限が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: "成功テスト", detail: nil, priority: 2, situation: 2, deadline: DateTime.tomorrow)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:task_1) { FactoryBot.create(:task, name:"正しいデータ1", situation: 1) }
    let!(:task_2) { FactoryBot.create(:task, name:"楽しい旅行データ0", situation: 0) }
    let!(:task_3) { FactoryBot.create(:task, name:"楽しい旅行データ1", situation: 1) }
    let!(:task_4) { FactoryBot.create(:task, name:"楽しいデータ0", situation: 2) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.ambiguous_name("正しい")).to include(task)
        expect(Task.ambiguous_name("正しい")).not_to include(task_2)
        expect(Task.ambiguous_name("楽しい旅行")).not_to include(task_1)
        expect(Task.ambiguous_name("楽しい旅行")).to include(task_3)
        expect(Task.ambiguous_name("楽しいデータ").count).to eq 1
        expect(Task.ambiguous_name("").count).to eq 5
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.situation_value("stand_by")).to include(task_2)
        expect(Task.situation_value("started")).not_to include(task_2)
        expect(Task.situation_value("finished")).not_to include(task_2)
        expect(Task.situation_value(nil).count).to eq 0
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.ambiguous_name("データ").situation_value("started").count).to eq 2
        expect(Task.ambiguous_name("旅行").situation_value("started")).to include(task_3)
        expect(Task.ambiguous_name("正しい").situation_value("finished").count).to eq 0
        expect(Task.ambiguous_name("楽しい").situation_value("finished")).to include(task_4)
      end
    end
  end
end