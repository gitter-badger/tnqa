class AddUssrIdToVotes < ActiveRecord::Migration
  def change
    add_index :votes, :user_id
  end
end
