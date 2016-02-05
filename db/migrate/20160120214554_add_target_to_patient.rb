class AddTargetToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :target, :integer
  end
end
