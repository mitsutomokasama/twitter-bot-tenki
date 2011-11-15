#encoding: utf-8

require 'sinatra'
require './tweet.rb'

get '/' do
	'under construction'
end

get '/daily_tweet' do
	Tweet.new.daily_tweet
end

