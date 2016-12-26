class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  def self.add(first_name, last_name, email, password)
    adm = Admin.find_or_create_by first_name: first_name, last_name: last_name, email: email
    unless adm.nil?
      adm.password = adm.password_confirmation = password
      adm.save
    end
    adm
  end

  def full_name
    "#{first_name} #{last_name}".trim
  end

  def as_json(options = nil)
    ActiveModelSerializers::SerializableResource.new(self).as_json
  end
end