class CreateEventsVolunteers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :events, :volunteers do |t|
      t.timestamps null: false
    end

    execute 'ALTER TABLE events_volunteers ADD CONSTRAINT pk_events_volunteers PRIMARY KEY (event_id, volunteer_id);'
  end
end
