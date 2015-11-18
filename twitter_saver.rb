require 'twitter'
require 'open-uri'

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV['TWITTER_KEY']
  config.consumer_secret = ENV['TWITTER_SECRET']
end

client.search("#lovebaldock").each do |tweet|
  open(tweet.user.profile_image_uri.to_s) {|f|
    File.open("tweets/#{tweet.id}.jpg","wb") do |file|
      file.puts f.read
    end
  }
  File.open("tweets/#{tweet.id}.txt","w") do |file|
    file.puts "#{tweet.user.name} -> #{tweet.text}"
  end
end
