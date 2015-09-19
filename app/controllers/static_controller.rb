require 'forgery'
class StaticController < ApplicationController
	def home
	end
	def news
		@newsItem = {
			:title => Forgery(:lorem_ipsum).title,
			:desc => Forgery(:lorem_ipsum).words(20) << "...",
			:date => Forgery(:date).date.strftime('%a, %Y-%m-%d @ %H:%M:%S')
		}
	end
end
