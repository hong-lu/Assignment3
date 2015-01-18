class ChangeTagsDefaultColor < ActiveRecord::Migration
  def change
  	change_column_default :tags, :color, '#95a5a6'
  end
end
