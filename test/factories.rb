FactoryBot.define do
  factory :user do |f|
    f.sequence(:name) { |n| "Test Users#{n}" }
    f.sequence(:email_address) { |n| "test#{n}@test.edu" }
    password { "password" }
  end
  factory :trip do |f|
    association :user
    f.sequence(:title) { |n| "Trip #{n}" }
    destination { "New York" }
    start_date { 1.week.from_now }
    end_date { 2.weeks.from_now }
    description { "Sample itinerary for testing." }
  end
end
