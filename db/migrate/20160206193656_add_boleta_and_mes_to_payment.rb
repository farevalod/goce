class AddBoletaAndMesToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :boleta, :integer
    add_column :payments, :mes, :integer
  end
end
