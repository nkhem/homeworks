class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.string :track_id, null: false
      t.string :band_id, null: false

      t.timestamps
    end

    change_column_null :bands, :name, false

  end
end
