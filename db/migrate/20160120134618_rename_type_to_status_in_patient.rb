class RenameTypeToStatusInPatient < ActiveRecord::Migration
  def change
	  rename_column :patients, :type, :status
  end
end
