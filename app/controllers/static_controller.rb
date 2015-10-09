require 'forgery'
class StaticController < ApplicationController
	def home
	end
	def news
		@url = "http://punktnews.tumblr.com/rss"
		@feed = Feedjira::Feed.fetch_and_parse(@url)
	end
	def explore
	end
end
