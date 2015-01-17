class AddDueDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :due_date, :string
  end
end
