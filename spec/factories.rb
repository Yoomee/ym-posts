FactoryGirl.define do
  
  factory :post do
    association :user, :factory => :user
    text "Donec congue lacinia dui, a porttitor lectus condimentum laoreet. Nunc eu ullamcorper orci. Quisque eget odio ac."
  end
  
end