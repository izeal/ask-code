class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :author, :author_id
  end
end
