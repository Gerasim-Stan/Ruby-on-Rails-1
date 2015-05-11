class AddTaskIdInSolution < ActiveRecord::Migration
  def change
    change_table :solutions do |t|
      t.references :task
    end
  end
end
