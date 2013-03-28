require 'rake'
require 'tweetstream'
require 'afinn_analyzer'
require 'yajl'

stream = Stream.find(ARGV[0])

TweetStream.configure do |config|
  config.consumer_key       = stream.consumer_key
  config.consumer_secret    = stream.consumer_secret
  config.oauth_token        = stream.oauth_token
  config.oauth_token_secret = stream.oauth_token_secret
  config.auth_method        = :oauth
end

puts "Starting TweetStream for #{stream.name}"

analyzer = AfinnAnalyzer.new "lib/AFINN-111.txt"

stream = TweetStream::Client.new

stream.on_error do |message|
  puts "#{stream.name} - error: #{message}"
end

stream.on_limit do |skip_count|
  puts "#{stream.name} - limit: #{skip_count}"
end

stream.on_reconnect do |timeout, retries|
  puts "#{stream.name} - timeout: #{timeout}, retries: #{retries}"
end

stream.sample do |status|
  mood = analyzer.analyze status.text
  Tweet.create(:date => status.created_at, :mood_positive => mood[:positive], :mood_negative => mood[:negative])
end
