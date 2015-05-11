class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :name
      t.string :body
      t.references :task, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
