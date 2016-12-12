class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string   :title          ,limit: 80   ,null: false
      t.text     :description
      t.datetime :start                       ,null: false
      t.datetime :end                         ,null: false
      t.integer  :min_volunteers
      t.integer  :max_volunteers

      t.timestamps
    end
  end
end
