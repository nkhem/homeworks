class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :track_name
      t.string :track_type
      t.string :lyrics
      t.string :album_id
    end
  end
end
