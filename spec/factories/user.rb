# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    user_type { 'admin' }
    email { Faker::Internet.email }
    password { SecureRandom.hex(10) }
  end
end
