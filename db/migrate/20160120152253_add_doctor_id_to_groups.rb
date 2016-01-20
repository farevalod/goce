class AddDoctorIdToGroups < ActiveRecord::Migration
  def change
    add_reference :groups, :doctor, index: true
  end
end
