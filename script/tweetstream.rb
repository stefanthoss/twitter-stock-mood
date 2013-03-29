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
  # puts status.text
  Tweet.create(:date => status.created_at, :stream_id => stream.id, :mood_positive => mood[:positive], :mood_negative => mood[:negative])
end
