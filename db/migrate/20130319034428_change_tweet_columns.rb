class ChangeTweetColumns < ActiveRecord::Migration
  def up
    remove_column :tweets, :text
    add_column :tweets, :tweet_id, :integer
    add_column :tweets, :mood_positive, :integer
    add_column :tweets, :mood_negative, :integer
  end
end
