class AddGroupIdToPatient < ActiveRecord::Migration
  def change
    add_reference :patients, :group, index: true
  end
end
