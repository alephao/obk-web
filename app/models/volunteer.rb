class Volunteer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :events

  def self.add(first_name, last_name, email, dob, password)
    v = Volunteer.find_or_create_by first_name: first_name, last_name: last_name, email: email, dob: dob
    unless v.nil?
      v.password = v.password_confirmation = password
      v.save
    end
    v
  end

  def full_name
    "#{first_name} #{last_name}".trim
  end
end