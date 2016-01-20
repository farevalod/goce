class AddJustificacionToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :justificacion, :boolean
  end
end
