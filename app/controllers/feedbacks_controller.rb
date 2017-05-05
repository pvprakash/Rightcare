class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_feedbacks
	def create
	  @feedback = Feedback.new(feedback_params.merge(user_id: params[:user_id]))
  	@feedback.save
    respond_to do |format|
      format.js
    end 
  end

  def index
  end

  def new
  end

  def destroy 
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
    respond_to do |format|
      format.js
    end
  end

  def get_feedbacks
    @caregiver = User.find(params[:caregiver_id] || params[:feedback][:caregiver_id])
    @feedbacks = @caregiver.caregiver_feedbacks.paginate(:page => params[:page], :per_page => 3).order(created_at: :desc)
  end

  private
  def feedback_params
  params.require(:feedback).permit(:content,:caregiver_id)
  end
end
