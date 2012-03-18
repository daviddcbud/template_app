FactoryGirl.define do
  factory :user do
    name     "Test Man"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end