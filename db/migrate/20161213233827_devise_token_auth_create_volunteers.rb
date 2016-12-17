class DeviseTokenAuthCreateVolunteers < ActiveRecord::Migration[5.0]
  def change
    change_table :volunteers do |t|
      t.string :provider, :null => false, :default => 'email'
      t.string :uid, :null => false, :default => ''

      ## Tokens
      t.json :tokens
    end

    add_index :volunteers, [:uid, :provider], :unique => true
  end
end
