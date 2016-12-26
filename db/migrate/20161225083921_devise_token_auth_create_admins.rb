class DeviseTokenAuthCreateAdmins < ActiveRecord::Migration[5.0]
  def change
    change_table :admins do |t|
      t.string :provider, :null => false, :default => 'email'
      t.string :uid, :null => false, :default => ''

      ## Tokens
      t.json :tokens
    end

    add_index :admins, [:uid, :provider], :unique => true
  end
end
