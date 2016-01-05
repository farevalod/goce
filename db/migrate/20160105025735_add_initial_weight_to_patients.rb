class AddInitialWeightToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :initial_weight, :integer
  end
end
