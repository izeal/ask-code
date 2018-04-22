module PostsHelper
  def author_of(post)
    User.find_by(id: post.author_id)
  end
end
