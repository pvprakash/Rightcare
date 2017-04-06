class UsersController < ApplicationController
	def patients
		@patients = User.joins(:roles).where("roles.name = 'patient' AND users.assign = false")
        respond_to do |format|
           format.js
        end
    end
end
