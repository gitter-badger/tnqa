class CreateReps < ActiveRecord::Migration
  def change
    create_table :reps do |t|
      t.integer :user_id
      t.integer :action_value
      t.string :action_name

      t.timestamps
    end
  end
end
