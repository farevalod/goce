class AddRutToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :rut, :string
    add_column :patients, :height, :integer
  end
end
