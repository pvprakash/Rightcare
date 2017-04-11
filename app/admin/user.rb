ActiveAdmin.register User do
   include PaymentConcerns::Razorpay
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :first_name, :last_name, :email, :password, :password_confirmation, :role, :avatar

index do
    selectable_column
    column :email
    column :first_name
    column :last_name
    column :role
    column :avatar do |p|
      image_tag p.avatar.url,width: '64px',height: "50px"
    end
    actions
  end

  form :html => { :multipart => true } do |f|   
   f.inputs "Users" do           
    render partial: 'form'  
   end                       
  end

  show do
    attributes_table do
      row :email
      row :first_name
      row :last_name
      row :user_id
      row :role
      row :avatar do |p|
        image_tag p.avatar.url,width: '64px',height: "50px"
      end
      row "Payment Details" do |u|
       link_to "Payment Details",admin_users_payment_details_path(u) if u.is_user? 
      end
    end
    active_admin_comments
  end 

  controller do
    def create
     user =  User.new(first_name: params[:first_name],last_name: params[:last_name],email: params[:email],password: params[:password],password_confirmation: params[:password_confirmation],avatar: params[:avatar],amount: params[:amount])
     if user.save
       user.add_role params[:role]
     end
       redirect_to admin_users_path
    end 

    def payment_details
      @user = User.find params[:id]
      @payments = @user.payments
    end

    def refund
        @user = User.find params[:id]
        @payment = Payment.find params[:payment_id]
        # refund_amount = params[:refund_amount]*100
        refund_amount = (@payment.price*15/100)*100*3
        payment_id = @payment.payment_id
        begin
        fetch_payment = Razorpay::Payment.fetch(payment_id)
        fetch_payment.refund({amount: refund_amount}) if refund_amount.present? 
        # fetch_payment.refund unless refund_amount.present?
        record = Payment.find_by_payment_id(payment_id)
        record.update_attributes(status: fetch_payment.status)
        flash[:notice] = "15% amount has refunded"
        rescue Exception
        flash[:notice] = "already refunded"
        end
        redirect_to admin_users_payment_details_path(@user)
    end
  end 

  # form do |f|
  #   f.inputs "User Details" do
  #     f.input :first_name
  #     f.input :last_name
  #     f.input :email
  #     f.input :password
  #     f.input :password_confirmation
  #     f.label :role, class: "select-role"
  #     select_tag "role", options_for_select(['patient', 'user','caregivers'],"patient")
  #     f.file_field :avatar
  #   end
  #   f.button "Create User"
  # end


end
