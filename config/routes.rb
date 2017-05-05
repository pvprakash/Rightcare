Rails.application.routes.draw do

  
  resources :subscribes
  mount Ckeditor::Engine => '/ckeditor'
  match "/admin/users/:id/refund/:payment_id" => 'admin/users#refund', via: [:get,:post], as: "admin_users_refund"
  match "/admin/users/:id/payment_details" => 'admin/users#payment_details', via: :get, as: "admin_users_payment_details"
  match "/admin/users/:id/payment_receipt/:payment_id" => 'admin/users#payment_receipt', via: :get, as: "admin_users_payment_receipt"
  match "/admin/users/select_city" => 'admin/users#select_city', via: :get, as: "admin_users_select_city"
  match "/admin/users/check_video_url" => 'admin/users#check_video_url', via: :get, as: "admin_users_check_video_url"

  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions',confirmations: 'confirmations'}
  resources :subscribes
  resources :blogs do
    collection do
      get 'archive'
    end
  end
  resources :pages do 
    collection do
      # get 'home'
      get 'about'
      get 'privacy_policy'
      get 'terms_condition'
      get 'faqs'
    end
  end
  resources :users do
    collection do
      get 'patients'
      get 'list_caregiver'
      get 'payment_details'
      get 'caregiver_details'
      get 'select_city'
      get 'dashboard'
    end
    member do
      get 'show_caregiver'
      get 'replacement'
      get 'patient_details'
    end
    resources :feedbacks
    resources :patients
    resources :payment, only: [:show] do
      collection do
      post 'purchase_status'
      end
      member do
        get 'payment_receipt',format: :pdf
      end
    end
  end

   
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'pages#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
