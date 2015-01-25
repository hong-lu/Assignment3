class Tag < ActiveRecord::Base
  validates :name, format: { with: /\A[a-zA-Z0-9_ -]+\z/,
  message: "only allows numbers and letters" }

  has_many :taggings
  has_many :tasks, through: :taggings

  def self.delete_empty_tags
  	Tag.all.each do |tag|
  		if (tag.tasks.count == 0)
  			tag.destroy
  		end
  	end
  end

end