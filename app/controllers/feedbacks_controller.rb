class FeedbacksController < ApplicationController
  before_action :authenticate_user!
	def create
		@feedback = Feedback.new(feedback_params.merge(user_id: params[:user_id]))
  	@feedback.save
    redirect_to dashboard_users_path
  end

  def index
  end

  def new
  end

  def destroy
  end

  private
  def feedback_params
  params.require(:feedback).permit(:content,:caregiver_id)
  end
end
