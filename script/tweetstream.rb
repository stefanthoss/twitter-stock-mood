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

keywords = []
stream.keywords.each { |keyword| keywords << keyword[:name] }

if keywords.empty?
  puts "Error: no keywords for stream #{stream.name}"
  exit
end

puts "Starting stream #{stream.name} with keywords #{keywords.inspect}"

analyzer = AfinnAnalyzer.new "lib/AFINN-111.txt"

tweetstream = TweetStream::Client.new

tweetstream.on_error do |message|
  puts "Stream #{stream.name} - error: #{message}"
end

tweetstream.on_limit do |skip_count|
  puts "Stream #{stream.name} - limit: #{skip_count}"
end

tweetstream.on_reconnect do |timeout, retries|
  puts "Stream #{stream.name} - timeout: #{timeout}, retries: #{retries}"
end

tweetstream.track(keywords) do |status|
  mood = analyzer.analyze status.text
  current_hour = Time.new(status.created_at.year, status.created_at.month, status.created_at.day, status.created_at.hour)
  tweets = Tweet.where("date = ?", current_hour)
  if tweets.count == 0
    # new hour
    Tweet.create(:date => current_hour, :stream_id => stream.id, :mood_positive => mood[:positive], :mood_negative => mood[:negative], :tweet_count => 1)
  else
    # same hour
    tweets.first.mood_positive = tweets.first.mood_positive + mood[:positive]
    tweets.first.mood_negative = tweets.first.mood_negative + mood[:negative]
    tweets.first.tweet_count = tweets.first.tweet_count + 1
    tweets.first.save
  end
end
