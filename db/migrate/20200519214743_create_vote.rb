class CreateVote < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :user , index: true
      t.references :work , index: true
      t.boolean :upvote

      t.timestamps
    end
  end
end
