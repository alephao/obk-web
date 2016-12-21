class VolunteerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :mobile_number,
             :landline_number, :dob, :wwccn, :sub_newsletter, :uid
end
