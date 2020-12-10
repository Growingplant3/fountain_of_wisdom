FactoryBot.define do
  factory :admin_user, class: User do
    name { "Administrator" }
    email { "admin@example.com" }
    password { "19!a@z?0" }
    password_confirmation { "19!a@z?0" }
    admin { "admin" }
  end

  factory :general_user, class: User do
    name { "General User" }
    email { "general@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { "not_admin" }
  end

  factory :another_user, class: User do
    name { "Another User" }
    email { "another@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { "not_admin" }
  end
end
