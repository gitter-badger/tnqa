# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.sentence(3, true, 4) }
    content { Faker::Lorem.paragraph(rand(2..6)) }
    user
  end
end
