class Tag < ActiveRecord::Base
  validates :name, format: { with: /\A[a-z0-9_-]+\Z/,
  message: "only allows numbers and letters" }

  has_many :taggings
  has_many :tasks, through: :taggings
end