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

	def show
	end

	def unsubscribe
		begin
		subscribe = Subscribe.find_by_token(params[:token])
    if subscribe.destroy
      flash[:notice] = "Successfully unsubscribed"
    else
    	flash[:warning] = "Already unsubscribed"
    end
    rescue Exception
    	flash[:warning] = "Already unsubscribed"
    end
    redirect_to root_path
	end

end
