class AddNulls < ActiveRecord::Migration
  def change
    change_column_null :tracks, :track_name, false
    change_column_null :tracks, :album_id, false
  end
end
