FactoryGirl.define do 

  sequence :email do |n|
    "user#{n}@example.com" 
  end

  factory :user do
    name 'Test User'
    email 
    password 'please'
    invitation_token 'faketoken'
  end
end

