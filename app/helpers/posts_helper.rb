module PostsHelper
  def find_author(post)
    if post.author_id
      if User.find_by(id: post.author_id).nil?
        "DELETED"
      else
        User.find_by(id: post.author_id).login
      end
    else
      "Anonymus"
    end
  end

  def link_to_author(post)
    find_author(post) == "Anonymus" || "DELETED" ? root_path : user_path(User.find_by(id: post.author_id))
  end
end
