class Blog < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_shortened_urls
end
