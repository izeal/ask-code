class AddCommentToHashtags < ActiveRecord::Migration[5.1]
  def change
    add_reference :hashtags, :comment, foreign_key: true
  end
end
