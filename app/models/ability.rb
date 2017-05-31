class Ability
  include CanCan::Ability
  include ActiveAdminRole::CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new
    if user.super_user?
      can :manage, :all
    elsif user.hospital?
      cannot :create, :all
      cannot :update, :all
      can [:create,:update], AdminUser
      can [:create,:update], User
      can [:create,:update], Patient
      # can [:create,:update], Caregiver
      can :manage, AdminUser, :id => user.id 
      can :manage, AdminUser, :admin_user_id => user.id
      can :manage, Patient, :admin_user_id => user.id
      can :manage, User, :admin_user_id => user.id
      can :manage, ActiveAdmin::Page, name: "Caregivers"
    else
      register_role_based_abilities(user)
    end

    # NOTE: Everyone can read the page of Permission Deny
    can :read, ActiveAdmin::Page, name: "Dashboard"
  end
end
