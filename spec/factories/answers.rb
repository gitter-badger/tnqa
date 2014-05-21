# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    content "smart answer"
    user
    question
  end

 factory :invalid_answer, class: Answer do
  	content nil
  end
end
