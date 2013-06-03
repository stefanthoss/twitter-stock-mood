require 'tweetstream'
require 'afinn_analyzer'
require 'yajl'

class TweetStreamer
  def initialize(stream_id)
    Rails.logger.info "Initialize TweetStreamer for ID #{stream_id}"

    @stream = Stream.find(stream_id)

    TweetStream.configure do |config|
      config.consumer_key       = @stream.consumer_key
      config.consumer_secret    = @stream.consumer_secret
      config.oauth_token        = @stream.oauth_token
      config.oauth_token_secret = @stream.oauth_token_secret
      config.auth_method        = :oauth
    end

    @keywords = []
    @stream.keywords.each { |keyword| @keywords << keyword[:name] }

    if @keywords.empty?
      Rails.logger.error "Error: no keywords for stream #{@stream.name}"
      exit
    end
  end

  def start
    Rails.logger.info "Starting stream #{@stream.name} (ID: #{ARGV[0]})"
    t = Thread.new {
      Rails.logger.info "Starting new thread for stream #{@stream.name}"

      analyzer = AfinnAnalyzer.new "lib/AFINN-111.txt"

      tweetstream = TweetStream::Client.new

      tweetstream.on_error do |message|
        Rails.logger.error "Stream #{@stream.name} - error: #{message}"
      end

      tweetstream.on_limit do |skip_count|
        Rails.logger.error "Stream #{@stream.name} - limit: #{skip_count}"
      end

      tweetstream.on_reconnect do |timeout, retries|
        Rails.logger.error "Stream #{@stream.name} - timeout: #{timeout}, retries: #{retries}"
      end

      tweetstream.track(@keywords) do |status|
        # Rails.logger.debug "New tweet: #{status.text}"
        mood = analyzer.analyze status.text
        current_hour = Time.new(status.created_at.year, status.created_at.month, status.created_at.day, status.created_at.hour)
        tweets = Tweet.where("date = ? AND stream_id = ?", current_hour, @stream.id)
        if tweets.count == 0
          # new hour
          Tweet.create(:date => current_hour, :stream_id => @stream.id, :mood_positive => mood[:positive], :mood_negative => mood[:negative], :tweet_count => 1)
        else
          # same hour
          tweets.first.mood_positive = tweets.first.mood_positive + mood[:positive]
          tweets.first.mood_negative = tweets.first.mood_negative + mood[:negative]
          tweets.first.tweet_count = tweets.first.tweet_count + 1
          tweets.first.save
        end
      end
    }
    return t.status
  end
end
