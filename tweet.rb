#encoding: utf-8

require 'rubygems'
require 'twitter'
require './weatherInfo'

class Tweet
	def initialize
		@weatherInfo = WeatherInfo.new

		Twitter.configure do |config|
			config.consumer_key 		= ENV['CONSUMER_KEY']
			config.consumer_secret		= ENV['CONSUMER_SECRET']
			config.oauth_token			= ENV['OAUTH_TOKEN']
			config.oauth_token_secret	= ENV['OAUTH_TOKEN_SECRET']
		end
	end

	def daily_tweet
		info = @weatherInfo.get_tokyo_info
		return "error" if info['weather'].empty?
		tweet = "今日の天気は#{info['weather']}。最高気温#{info['max']}度、最低気温#{info['min']}度。" +
			"降水確率 (06-12)#{info['06-12']}% (12-18)#{info['12-18']}% (18-24)#{info['18-24']}%です。"
		update(tweet)
		nil
	end

	def update(tweet)
		return nil unless tweet

		begin
			Twitter.update(tweet.chomp)
		rescue => ex
			nil
		end
	end
end
