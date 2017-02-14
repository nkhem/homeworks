class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.integer :user_id, null: false, unique: true
      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
