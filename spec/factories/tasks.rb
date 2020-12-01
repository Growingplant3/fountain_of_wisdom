FactoryBot.define do
  factory :task do
    name { "忘年会" }
    detail { nil }
    priority { 0 }
    situation { 0 }
    deadline { DateTime.now + 1.day }  
  end
end
