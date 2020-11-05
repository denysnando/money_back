# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    advertiser_name { Faker::Name.name }
    url { Faker::Internet.url }
    description { Faker::Name.name }
    starts_at { Time.zone.tomorrow }
    ends_at { Time.zone.today + 1.month }
    enabled { false }
    premium { true }
  end
end
