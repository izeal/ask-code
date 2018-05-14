class Post < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy

  validates :text, presence: true, length: { maximum: 255 }

  def author_object
    author || Anonymous.new
  end
end
