class Comment < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :post
  validates :text, presence: true, length: { maximum: 255 }
  validates :post, presence: true

  def user_object
    user || Anonymous.new
  end
end
