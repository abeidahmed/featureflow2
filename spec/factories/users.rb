FactoryBot.define do
  factory :user, aliases: %i[creator] do
    first_name { "John" }
    last_name { "Doe" }
    sequence(:email) { |n| "johndoe#{n}@example.com" }
    password { "secretpassword" }
    sequence(:auth_token) { |n| "secret_token#{n}" }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
