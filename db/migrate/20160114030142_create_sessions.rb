class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.date :date
      t.references :group, index: true
      t.references :doctor, index: true

      t.timestamps
    end
  end
end
