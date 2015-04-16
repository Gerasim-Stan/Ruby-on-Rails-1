class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :term

      t.timestamps null: false
    end
  end
end
