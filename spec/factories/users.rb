# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "emaqqq#{n}@factory.com"
  end

  factory :user do
    name { Faker::Name.name }
    email
    password "foobarrr"
    password_confirmation { |u| u.password }
  end

  factory :user2, class: User do
    name "Name"
    email
    password "password"
    password_confirmation { |u| u.password }
  end

  factory :invalid_user, class: User do
  	name nil
  	password nil
  	password_confirmation nil
  end
end
