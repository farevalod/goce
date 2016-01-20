class AddAjustmentToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :adjustment, :boolean
  end
end
