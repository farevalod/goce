class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :address
      t.string :day
      t.time :time

      t.timestamps
    end
  end
end
