require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = '0Sv48GPMRWnwKIlolXOFWw'
  config.consumer_secret    = 'QdAwBuKqy7UKz1LrRcYv3PO0K9xEy7sljL3fXUnzzmU'
  config.oauth_token        = '381129932-BCyEjeYY4JlkW1qzWDv0UXn7mIMRufAMTKFvJr5h'
  config.oauth_token_secret = 'O71GJD7vNYtD1pvCwRqAmflfnZqXgr2kfiRDM'
  config.auth_method        = :oauth
end

puts 'Starting TweetStream'

TweetStream::Daemon.new.on_error do |message|
  puts message
end.on_limit do |skip_count|
  puts skip_count
end.on_reconnect do |timeout, retries|
  puts "#{timeout}, #{retries}"
end.sample do |status|
  Tweet.create(:text => status.text, :date => status.created_at, :retweet_count => status.retweet_count)
end
