ActiveAdmin.register AdminUser do
  role_changeable
  permit_params :email, :password, :password_confirmation
  menu priority: 1

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :address
    column :mobile
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do         
      render partial: 'form'  
    end 
  end

  controller do
    def index
      index! do |format|
        case params[:scope]
        when 'doctor'
         return "0"
        when 'hospital'
         return "1"
        when 'admin'
          return "99"
        when 'all'
          return 'all'
        end
        @admin_users = AdminUser.where("admin_user_id = #{current_admin_user.id} OR id = #{current_admin_user.id}").page(params[:page])
        @admin_users = @admin_users.where("role = #{params[:scope]}") if params[:scope].present? 
        format.html
      end
    end
    def create
      admin = AdminUser.new(admin_user)
      if current_admin_user.present? 
       admin = current_admin_user.admin_users.new(admin_user)
      end
      admin.save ? flash[:notice] = 'successfully saved' : flash[:error] = "something went wrong" 
      redirect_to admin_admin_users_path
    end

    def update
      admin = AdminUser.find(params[:id])
      if current_admin_user.super_user?
        admin.update_attributes(admin_user) ? flash[:notice] = "successfully update" : flash[:error] = "something went wrong"
      elsif current_admin_user.doctor? && admin.doctor?
        admin.update_attributes(admin_user) ? flash[:notice] = "successfully update" : flash[:error] = "something went wrong"
      elsif current_admin_user.hospital? && (admin.doctor? || admin.hospital?)
        admin.update_attributes(admin_user) ? flash[:notice] = "successfully update" : flash[:error] = "something went wrong"
      else
        flash[:error] = "You are unauthorized"
      end
      redirect_to admin_admin_users_path
    end

    def destroy
      admin = AdminUser.find(params[:id])
      flash[:notice] = "successfully removed"
      if current_admin_user.super_user?
        admin.destroy
      elsif current_admin_user.doctor? && admin.doctor?
        admin.destroy
      elsif current_admin_user.hospital? && (admin.doctor? || admin.hospital?)
        admin.destroy
      else
        flash[:notice] = nil
        flash[:error] = "You are unauthorized"

      end
      redirect_to admin_admin_users_path
    end

    private
    def admin_user
       params.require(:admin_user).permit(:name,:address,:mobile,:email,:password,:password_confirmation,:role)
    end
  end
end
