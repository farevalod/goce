class AddTypeToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :type, :integer
  end
end
