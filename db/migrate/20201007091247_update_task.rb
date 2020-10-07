class UpdateTask < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :user_id, :assignee
    add_column :tasks, :type, :string
    add_reference :tasks, :created_by,
      foreign_key: {to_table: :users}, index: true, null: false
  end
end
