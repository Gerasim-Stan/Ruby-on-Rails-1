class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :text

      t.timestamps null: false
    end
  end
end
