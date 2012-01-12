FactoryGirl.define do 

  sequence :email do |n|
    "user#{n}@example.com" 
  end

  factory :user do
    name 'Test User'
    email 
    password 'password123'
    house
  end

  factory :house do
    name 'Our House'
  end

  factory :support_request do
    name "John Appleseed"
    email
    message "Seems like theres a serious lack of apples"
  end
end

