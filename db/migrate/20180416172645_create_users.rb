class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :login
      t.string :email
      t.string :avatar_url
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
