class CreateTableGroupsPatients < ActiveRecord::Migration
  def change
    create_table :groups_patients do |t|
      t.references :group, index: true
      t.references :patient, index: true
    end
  end
end
