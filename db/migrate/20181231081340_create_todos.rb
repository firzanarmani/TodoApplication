class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :item, null: false
      t.text :details
      t.boolean :done, null: false, default: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
