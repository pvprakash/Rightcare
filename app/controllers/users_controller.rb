class UsersController < ApplicationController
   # layout false, :only => :show_caregiver
  def patients
    @patients = User.joins(:roles).where("roles.name = 'patient' AND users.assign = false")
    respond_to do |format|
       format.js
    end
  end

  def list_caregiver
    code_hash = {"en" => 600, "ex" => 900, "sc" => 1200, "qn" =>2400}
    amount = code_hash[params["code"]]
  # @caregivers = User.joins(:roles).where("roles.name = 'caregiver' AND (users.assign = false AND users.amount = #{amount})")
    @caregiver_list = User.joins(:roles).active.where("roles.name = 'caregiver' AND ( users.assign = false AND users.amount = #{amount})")
    @caregivers = @caregiver_list.where(pin_code: current_user.pin_code)  if current_user.pin_code.present?
    @caregivers = @caregiver_list  unless @caregivers.present?
    @caregivers = @caregivers.paginate(:page => params[:page], :per_page => 16).order(created_at: :desc)
  end

  def show_caregiver
    
    @continue_caregiver = params[:continue]
    @caregiver = User.find(params[:id])
    @is_assign = current_user.patient.assign_caregiver
    @has_payment = Payment.active.find_by(user_id: current_user.id) 
    unless @caregiver.active
      flash[:notice] = "Something went wrong"
      redirect_to root_path
    end
  end

  def replacement
    @caregiver = User.find(params[:id])
    payment = Payment.active.find_by_user_id(current_user.id)
    last_caregiver = User.find(payment.caregiver_id)
    last_caregiver.update_attributes(assign: false)
    @caregiver.update_attributes(assign: true)
    payment.update_attributes(caregiver_id: @caregiver.id)
    replacement = Replacement.new(user_id: current_user.id, caregiver_id: @caregiver.id,last_caregiver_id: last_caregiver.id)
    replacement.save
    flash[:notice] = "Successfully replacement"
    redirect_to root_path
  end

  def payment_details
    @payments = current_user.payments
  end

  def patient_details
    @patient = current_user.patient
  end

  def caregiver_details
    if (caregiver_id = current_user.patient.try(:assign_caregiver).try(:caregiver_id)) && (current_user.patient.try(:assign_caregiver).try(:assign) == true)
      @caregiver = User.find(caregiver_id)
      last_payment = current_user.payments.active.try(:last)
      last_payment_date = last_payment.try(:created_at)
      caregiver_releasing_date = last_payment.try(:delayed_job).try(:run_at)
      @remain_releasing_time = ((caregiver_releasing_date - last_payment_date) / 3600).round
    end
  end


  def dashboard
    if (caregiver_id = current_user.patient.try(:assign_caregiver).try(:caregiver_id)) && (current_user.patient.try(:assign_caregiver).try(:assign) == true)
      @caregiver = User.find(caregiver_id)
      @feedbacks = @caregiver.caregiver_feedbacks.paginate(:page => params[:page], :per_page => 1).order(created_at: :desc)
      last_payment = current_user.payments.active.try(:last)
      last_payment_date = last_payment.try(:created_at)
      caregiver_releasing_date = last_payment.try(:delayed_job).try(:run_at)
      @remain_releasing_time = ((caregiver_releasing_date - last_payment_date) / 3600).round
    end
    @patient = current_user.patient
  end

  def select_city
    @all_cities = CS.cities(params[:state_name])
    # @cities = @all_cities & ["Vidisha"]
    @cities = @all_cities
    respond_to do |format|
      format.js
    end
  end
end
