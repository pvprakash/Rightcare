class PasswordsController < Devise::PasswordsController 
  prepend_before_action :require_no_authentication
  # Render the #edit only if coming from a reset password email link
  # append_before_action :assert_reset_token_passed, only: :edit

  # GET /resource/password/new
  def new
    self.resource = resource_class.new
    @resource = self.resource
    respond_to do |format|
       format.html
       format.js
    end
  end
end