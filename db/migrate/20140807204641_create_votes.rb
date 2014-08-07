class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.references :voteable, polymorphic: true
      t.integer :voter_id, null: false

      t.timestamps
    end

    add_index :votes, :voteable_id
  end
end
