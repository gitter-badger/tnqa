class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :subscribable_id
      t.string :subscribable_type
      t.timestamps
    end
  end
end
