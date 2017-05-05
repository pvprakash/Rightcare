class SubscribesController < ApplicationController
	def new
	end

	def create
		if params[:email].include? "gmail.com"
			subscribe = Subscribe.new(email: params[:email])
    	@message = "successfully subscribe" if subscribe.save
		else
			@message = "email domain should be gmail"
		end
		flash[:notice] = @message
	end
end
