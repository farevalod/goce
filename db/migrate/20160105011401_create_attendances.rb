class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :patient, index: true
      t.references :group, index: true
      t.integer :weight

      t.timestamps
    end
  end
end
