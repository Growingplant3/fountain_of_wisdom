FactoryBot.define do
  factory :task do
    name { "正しいデータ0" }
    detail { nil }
    priority { 0 }
    situation { 0 }
    deadline { "3000/01/01".to_datetime }  
  end

  factory :another_task, class: Task do
    name { "ラベル用タスク" }
    detail { nil }
    priority { 1 }
    situation { 1 }
    deadline { "4000/12/31".to_datetime}
  end
end
