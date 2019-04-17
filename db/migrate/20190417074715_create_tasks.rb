class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :project_id, null: false
      t.integer :user_id
      t.string :title, null: false
      t.text :description, null: false
      t.string :status, null: false,  default: "new"

      t.timestamps
    end
  end
end
