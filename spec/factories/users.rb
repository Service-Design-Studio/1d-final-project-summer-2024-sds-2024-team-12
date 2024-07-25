# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      phone { "1234567890" }
      password { "123456" }
      password_confirmation { "123456" }
    end
  end
  