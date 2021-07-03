FactoryBot.define do
  factory :collaborator do
    role { "editor" }
    joined_at { "2021-07-03 17:55:47" }
    token { SecureRandom.urlsafe_base64 }
    user
    account

    trait :owner do
      role { "owner" }
    end
  end
end
