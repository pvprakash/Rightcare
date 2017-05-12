class SubscribesController < ApplicationController
	def new
	end

	def create
		if params[:email].include? "gmail.com"
		  subscribe = Subscribe.new(email: params[:email])
    	
    	if subscribe.save
    		flash[:notice] = "Successfully Subscribe" 
    	else
    		flash[:warning] = "Already Subscribed" 
    	end
		else
			flash[:warning] = "Email Domain Should be gmail"
		end
		redirect_to :back
	end
end
