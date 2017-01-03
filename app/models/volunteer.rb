class Volunteer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :events

  validates :first_name, :last_name, :email, :dob, :mobile_number, presence: true
  validates :email, email: true, uniqueness: true
  validates :wwccn, presence: true, if: ['!dob.nil?', :more_than_eighteen?]
  validates :gender, inclusion: { in: %w(M F O) }

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

  def as_json(options = nil)
    ActiveModelSerializers::SerializableResource.new(self).as_json
  end

  private

  def more_than_eighteen?
    (Time.zone.today.year - dob.to_date.year) >= 18
  end
end