class CreateDoctorsSessions < ActiveRecord::Migration
  def change
    create_table :doctors_sessions do |t|
      t.references :doctor_id, index: true
      t.references :session_id, index: true
    end
  end
end
