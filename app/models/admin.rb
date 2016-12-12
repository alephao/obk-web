class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

end
