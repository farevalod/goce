class AddEmailToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :email, :string
    add_column :doctors, :profession, :string
  end
end
