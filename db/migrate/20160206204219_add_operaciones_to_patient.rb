class AddOperacionesToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :cirugia, :boolean
    add_column :patients, :medicamentos, :string
  end
end
