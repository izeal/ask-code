class Anonymous
  attr_reader :name, :login, :email, :avatar_url

  def initialize
    @name = "Anonymous"
    @email = ""
    @login = "Anonymous"
    @avatar_url = ''
  end

  def posts
    []
  end

  def id
  end
end
