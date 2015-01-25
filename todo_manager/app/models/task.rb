class Task < ActiveRecord::Base
  validates :title, presence: true,
                    length: { minimum: 2 }
  has_many :taggings
  has_many :tags, through: :taggings

  validate do |task|
    task.tags.each do |tag|
      next if tag.valid?
      tag.errors.full_messages.each do |msg|
        # you can customize the error message here:
        task.errors[:base] << "Tag Error: #{msg}"
      end
    end
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).tasks
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_array
    tags.map(&:name)
  end
  
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.find_or_create_by(name: n.strip)
    end
    # if (/\A[a-zA-Z0-9_ -,]+\z/ =~ names) != nil
    #   self.tags = names.split(",").map do |n|
    #     Tag.where(name: n.strip).first_or_create
    #   end
    # else
    #   self.errors.add(:base, "This person is evil")
    #   raise "Unable to remove business."
    # end
  end

end