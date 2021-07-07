FactoryBot.define do
  factory :stage do
    name { "Under review" }
    color { "#24292e" }
    account
  end
end
