FactoryBot.define do
  factory :account do
    name { "Example account" }
    sequence(:subdomain) { |n| "example#{n}" }
    sequence(:cname) { |n| "subdomain.example#{n}.com" }
    status { "active" }
    creator

    trait :inactive do
      status { "inactive" }
    end
  end
end
