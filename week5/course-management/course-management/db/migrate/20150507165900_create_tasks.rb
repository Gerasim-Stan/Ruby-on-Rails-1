class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.references :solution, index: true, foreign_key: true
      t.references :lecture

      t.timestamps null: false
    end
  end
end
