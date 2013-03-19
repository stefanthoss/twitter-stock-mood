class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.datetime :date
      t.integer :retweet_count
      t.integer :stream_id

      t.timestamps
    end
  end
end
