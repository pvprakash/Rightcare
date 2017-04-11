class UsersController < ApplicationController
	def patients
		@patients = User.joins(:roles).where("roles.name = 'patient' AND users.assign = false")
		respond_to do |format|
		   format.js
		end
    end

    def list_caregiver
        code_hash = {"en" => 600, "ex" => 900, "sc" => 1200, "qn" => "2400"}
        amount = code_hash[params["code"]]
    	@caregivers = User.joins(:roles).where("roles.name = 'caregiver' AND (users.assign = false AND users.amount = #{amount})")
    end

    def show_caregiver
    	@caregiver = User.find(params[:id])
        @has_payment = Payment.find_by(user_id: current_user.id,caregiver_id: @caregiver.id)
    end

    
end
