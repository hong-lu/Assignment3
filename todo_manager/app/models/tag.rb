class Tag < ActiveRecord::Base
  validates :name, format: { with: /[a-zA-Z0-9]/,
  message: "only allows numbers and letters" }

  has_many :taggings
  has_many :tasks, through: :taggings
end