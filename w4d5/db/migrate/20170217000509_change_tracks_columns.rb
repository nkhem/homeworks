class ChangeTracksColumns < ActiveRecord::Migration
  def change
    rename_column :tracks, :track_name, :title
  end
end
