class AddUrlFotosToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :url_foto_antes, :string
    add_column :patients, :url_foto_despues, :string
  end
end
