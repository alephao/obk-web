class VolunteerProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :mobile_number,
             :landline_number, :dob, :sub_newsletter
end