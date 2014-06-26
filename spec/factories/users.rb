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

    trait :with_reputation do 
      after :create do |object|
        object.reps.create action_value: 20_000, action_name: 'xxx'
      end
    end
  end

  factory :invalid_user, class: User do
  	name nil
  	password nil
  	password_confirmation nil
  end
end
