class DeviseCreateVolunteers < ActiveRecord::Migration[5.0]
  def change
    create_table :volunteers do |t|
      ## Database authenticatable
      t.string  :first_name      ,limit: 40  ,null: false
      t.string  :last_name       ,limit: 40
      t.string  :email           ,limit: 255 ,null: false
      t.string  :mobile_number   ,limit: 20
      t.string  :landline_number ,limit: 20
      t.date    :dob                         ,null: false
      t.string  :wwccn           ,limit: 15
      t.boolean :sub_newsletter              ,default: true
      t.string  :encrypted_password          ,null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :volunteers, :email,                unique: true
    add_index :volunteers, :reset_password_token, unique: true
    # add_index :volunteers, :confirmation_token,   unique: true
    # add_index :volunteers, :unlock_token,         unique: true
  end
end
