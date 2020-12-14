FactoryBot.define do
  factory :label do
    name { "正しいラベル" }
  end

  factory :rare_label, class: Label do
    name { "珍しいラベル" }
  end

  factory :common_label, class: Label do
    name { "よくあるラベル" }
  end
end
