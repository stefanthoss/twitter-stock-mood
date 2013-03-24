class AddOauthColumns < ActiveRecord::Migration
  def up
    add_column :streams, :consumer_key, :string
    add_column :streams, :consumer_secret, :string
    add_column :streams, :oauth_token, :string
    add_column :streams, :oauth_token_secret, :string
  end
end
