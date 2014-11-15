# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "notblanc title"
  	content "notblanc content"
    user
  end

 factory :invalid_question, class: Question do
  	title nil
  	content nil
  end
end
