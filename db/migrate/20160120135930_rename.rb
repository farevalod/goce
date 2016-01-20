class Rename < ActiveRecord::Migration
  def change
	  rename_column :doctors_sessions, :doctor_id_id, :doctor_id
	  rename_column :doctors_sessions, :session_id_id, :session_id
  end
end
