FactoryGirl.define do
  factory :volunteer, class: Volunteer do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    gender 'M'
    dob { FFaker::Time.date }
    mobile_number { FFaker::PhoneNumberAU.mobile_phone_number }
    landline_number { FFaker::PhoneNumberAU.phone_number }
    password { FFaker::Internet.password }
    password_confirmation { password }
  end
end