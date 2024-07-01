FactoryBot.define do
  factory :user do
    username { "test user" }
    email { "test@example.com" }
    password { "password" }
    # 他の必要な属性もここに追加する
  end
end
