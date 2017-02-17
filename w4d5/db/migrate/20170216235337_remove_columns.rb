class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :bands, :album_id
    remove_column :albums, :track_id
  end
end
