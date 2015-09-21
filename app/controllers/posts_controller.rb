class PostsController < ApplicationController
	def create_post
		respond_to do |format|
			if not @current_user
				flash[:error] = " You must be logged in to create a post!"
 				format.html{redirect_to url_for(:controller => :users, :action => :login)}
			else
				format.html {render :create_post}
			end
		end
	end
end
