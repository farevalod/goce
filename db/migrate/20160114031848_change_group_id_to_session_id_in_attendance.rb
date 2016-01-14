class ChangeGroupIdToSessionIdInAttendance < ActiveRecord::Migration
  def change
	  rename_column :attendances, :group_id, :session_id
  end
end
