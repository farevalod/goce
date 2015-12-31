class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :patient, index: true
      t.integer :amount
      t.string :details

      t.timestamps
    end
  end
end
