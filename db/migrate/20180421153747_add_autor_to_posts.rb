class AddAutorToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :author, :integer
  end
end
