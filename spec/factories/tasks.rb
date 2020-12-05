FactoryBot.define do
  factory :task do
    name { "正しいデータ0" }
    detail { nil }
    priority { 0 }
    situation { 0 }
    deadline { "3000/01/01".to_datetime }  
  end
end
