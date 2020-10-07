class RenameColumnTask < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :assignee, :assignee_id
  end
end
