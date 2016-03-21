class AddCostToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :cost, :integer
  end
end
