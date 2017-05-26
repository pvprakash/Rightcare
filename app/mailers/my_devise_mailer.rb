class MyDeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  # Overrides same inside Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    attachments.inline['logo.png'] =  File.read(Rails.root.join("app/assets/images/logo.png"))
    set_organization_of record
    super
  end

  # Overrides same inside Devise::Mailer
  def reset_password_instructions(record, token, opts={})
    set_organization_of record
    super
  end

  # Overrides same inside Devise::Mailer
  def unlock_instructions(record, token, opts={})
    set_organization_of record
    super
  end

  private
  ##
  # Sets organization of the user if available
  def set_organization_of(user)
    @organization = user.organization rescue nil
  end
end