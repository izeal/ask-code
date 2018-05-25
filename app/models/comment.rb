class Comment < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :post
  has_many :hashtags, dependent: :destroy

  validates :text, presence: true, length: { maximum: 255 }
  validates :post, presence: true

  def user_object
    user || Anonymous.new
  end
end
