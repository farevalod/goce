class CreateAttendaces < ActiveRecord::Migration
  def change
    create_table :attendaces do |t|
      t.references :patient, index: true
      t.references :group, index: true
      t.integer :weight

      t.timestamps
    end
  end
end
