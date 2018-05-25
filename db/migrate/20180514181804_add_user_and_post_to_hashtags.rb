class AddUserAndPostToHashtags < ActiveRecord::Migration[5.1]
  def change
    add_reference :hashtags, :user, foreign_key: true
    add_reference :hashtags, :post, foreign_key: true
  end
end
