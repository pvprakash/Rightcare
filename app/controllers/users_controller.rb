class UsersController < ApplicationController
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
        @caregivers = User.joins(:roles).where("roles.name = 'caregiver' AND ( users.assign = false AND users.amount = #{amount})")
        @caregivers = @caregivers.where(pin_code: current_user.pin_code)  if current_user.pin_code.present? 
    end

    def show_caregiver
    	  @caregiver = User.find(params[:id])
        @has_payment = Payment.find_by(user_id: current_user.id)
    end

    def replacement
       @caregiver = User.find(params[:id])
       payment = Payment.find_by_user_id(current_user.id)
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
end
