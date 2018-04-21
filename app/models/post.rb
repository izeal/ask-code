class Post < ApplicationRecord
  belongs_to :user
  validates :text, presence: true, length: { maximum: 255 }
  validates :answer, presence: true, on: :update, length: { maximum: 255 }
end
