Rails.application.routes.draw do
  match "*path" => redirect("https://dot.calmbit.com/%{path}"), :constraints => { :protocol => "http://" }, :via => [:get, :post]
  resources :u2_f_registrations
  resources :announcements
  resource :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
    root 'static#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
       get 'user/logout' => "users#logout"
       get 'me' => "users#my_profile"
       get 'user/validate' => 'users#validate'
	get 'user/register' => 'users#new'
       get 'user/login' => 'users#login'
       post 'user/login_attempt' => 'users#login_attempt'
       get 'user/validation_requested' => 'users#needs_validation'
	get 'user/:id' => 'users#show'
       get 'news' => 'static#news'
       get 'post/create' => 'posts#create_post'
       get '/explore' => 'static#explore'
       get '/ping' => 'static#ping'
       get '/admin_panel' => 'users#admin_panel'
       get '/annquash' => 'application#annquash!'
       get '/u2f_auth' => 'u2_f_authentications#new'
       post '/u2f_auth' => 'u2_f_authentications#create'
       health_check_routes
      # match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all

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
