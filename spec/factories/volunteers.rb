FactoryGirl.define do
  factory :volunteer, class: Volunteer do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    dob { FFaker::Time.date }
    password { FFaker::Internet.password }
    password_confirmation { password }
  end
end