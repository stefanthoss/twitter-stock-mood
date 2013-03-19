class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.datetime :date
      t.integer :stream_id
      t.integer :mood_positive
      t.integer :mood_negative

      t.timestamps
    end
  end
end
