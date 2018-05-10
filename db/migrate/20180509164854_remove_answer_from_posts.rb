class RemoveAnswerFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :answer
  end
end
