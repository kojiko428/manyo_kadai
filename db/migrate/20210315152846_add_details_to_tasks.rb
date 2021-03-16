class AddDetailsToTasks < ActiveRecord::Migration[5.2]
  def change
    # deadlineはdatetime/statusとpriorityはintegerがよさそう
    add_column :tasks, :deadline, :datetime
    add_column :tasks, :status, :integer
    add_column :tasks, :priority, :integer
  end
end
