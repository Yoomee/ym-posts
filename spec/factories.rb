FactoryGirl.define do

  factory :comment do
    user
    post
    text "Morbi euismod magna ac lorem rutrum elementum."
  end
  
  factory :post do
    user
    text "Donec congue lacinia dui, a porttitor lectus condimentum laoreet. Nunc eu ullamcorper orci. Quisque eget odio ac."
  end
  
  factory :user do |f|
    first_name "Charles"
    last_name "Barrett"
    sequence(:email) {|n| "user#{n}@email.com"}
    password "password"
  end
  
end