FactoryGirl.define do
  factory :admin, class: Admin do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    password_confirmation { password }
  end
end