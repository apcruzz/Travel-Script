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

  factory :journal_entry do
    association :trip
    user { trip.user }
    sequence(:title) { |n| "Entry #{n}" }
    content { "Exploring the world with detailed notes." }
    date { Time.current }
  end

  factory :comment do
    association :journal_entry
    user { journal_entry.user }
    content { "Love this update!" }
  end
end
