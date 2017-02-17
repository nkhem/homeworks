class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.string :album_id
      
      t.timestamps
    end
  end
end
