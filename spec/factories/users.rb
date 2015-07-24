FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "John Doe-#{n}" }
    sequence(:email) { |n| "johndoe-#{n}@example.com" }
    password 'password'

    factory :admin do
      admin true
    end
  end
end
