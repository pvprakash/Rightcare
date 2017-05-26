class CareersController < ApplicationController
	def new
		@career = Career.new 
	end

	def create
		@career = Career.new(career_params)
		if @career.save
			flash[:notice] = "successfully Applied"
		  redirect_to root_path
		else
			flash[:errors] = "Please Enter Valid Mobile Number OR Name"
		  redirect_to about_pages_path
		end
	end

	protected
	def career_params
	 params.require(:career).permit(:name, :mobile)
	end
end
