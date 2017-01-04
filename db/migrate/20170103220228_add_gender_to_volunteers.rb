class AddGenderToVolunteers < ActiveRecord::Migration[5.0]
  def change
    add_column :volunteers, :gender, :string, null: false
  end
end
