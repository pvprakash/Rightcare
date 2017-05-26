ActiveAdmin.register User do
  include PaymentConcerns::Razorpay
  menu priority: 2

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
permit_params :first_name, :last_name, :email, :password, :password_confirmation, :role, :avatar,:city,:state,:extra_data

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
      row :state 
      row :city
      row :active
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
     user =  User.new(first_name: params[:first_name],last_name: params[:last_name],email: params[:email],password: params[:password],password_confirmation: params[:password_confirmation], pin_code: params[:pin_code],state: params[:state],city: params[:city],active: true,avatar: params[:avatar])
     
     if params[:role].eql?('caregiver')
      user.amount = params[:amount]
      user.skills = params[:skills]
      user.video_url = params[:url]
      user.languages = params[:languages]
      user.gender = params[:gender]
      user.extra_data = {id_prof: params[:id_prof],emergency_contact: params[:emergency_contact],experience: params[:experience],profile: params[:profile]}
     end
     if user.save
       user.add_role params[:role]
        flash[:notice] = 'successfully saved'
       redirect_to admin_users_path
     else
       str = ""
        user.errors.messages.each do |key, value|
          str  << key.to_s+" "+value.join()+", "
        end
        flash[:notice] =  str
        redirect_to '/admin/users/new'
      end
    end 

    def edit
      @resource = User.find(params[:id])
    end

    def update
     user = User.find(params[:id])
     user_hash = {first_name: params[:first_name],last_name: params[:last_name],email: params[:email], pin_code: params[:pin_code],state: params[:state],city: params[:city],active: true}
     user_hash.merge!(password: params[:password],password_confirmation: params[:password_confirmation]) if params[:password].present? && params[:password_confirmation].present?
     user_hash.merge!(avatar: params[:avatar]) if params[:avatar].present? 
     if params[:role].eql?('caregiver')
      user_hash = user_hash.merge(amount:params[:amount],skills:params[:skills],video_url: params[:url],languages: params[:languages] ,gender: params[:gender],extra_data: {id_prof: params[:id_prof],emergency_contact: params[:emergency_contact],experience: params[:experience],profile: params[:profile]})
     end
     if user.update_attributes(user_hash)
      flash[:notice] =  'successfully updated'
      redirect_to admin_users_path
     else
       str = ""
        user.errors.messages.each do |key, value|
          str  << key.to_s+" "+value.join()+", "
        end
        flash[:error] =  str
        redirect_to "/admin/users/#{user.id}/edit"
      end
    end 

    def payment_details
      @user = User.find params[:id]
      @payments = @user.payments
    end

    def payment_receipt
      @payment = Payment.find(params[:payment_id])
      kit = WickedPdf.new.pdf_from_string(render_to_string('payment/payment_receipt.html.erb', layout: 'pdf.html.erb'))
      send_data kit,
      filename: "Reciept #{Date.today.strftime('%Y%m%d')}.pdf",
      type: 'application/pdf'
      # respond_to do |format|
      #   format.pdf do
      #     render pdf: "file_name", template: 'payment/payment_receipt.html.erb' # Excluding ".pdf" extension.
      #   end
      # end
    end

    def refund
        @user = User.find params[:id]
        @payment = Payment.find params[:payment_id]
        @payment.caregiver_relase
        @payment.update_attributes(active: false)
        result = @payment.delay(run_at: 360.hours.from_now).refund_at
        if result
        flash[:notice] = "15% amount has refunded"
        else
        flash[:notice] = "already refunded"
        end
        redirect_to admin_users_payment_details_path(@user)
    end

    def select_city
      @cities = CS.cities(params[:state_name])
        respond_to do |format|
        format.js
      end
    end

    def check_video_url
      begin 
        video = VideoInfo.new(params[:video_url])
        @message = "Valid URL" 
      rescue Exception
        # flash[:notice] = "video url invalid"
        @message = "Invalid URL"
      end
        respond_to do |format|
        format.json { render json: @message }
      end
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
