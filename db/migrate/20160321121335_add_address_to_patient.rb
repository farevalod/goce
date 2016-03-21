class AddAddressToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :address, :string
  end
end
