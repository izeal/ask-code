class Hashtag < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :post, required: false
  belongs_to :comment, required: false
end
