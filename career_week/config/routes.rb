Rails.application.routes.draw do

  get 'login' => 'users#login'
  post 'enter' => 'users#enter'
  
  get 'register' => 'users#register'
  post 'create' => 'users#create'
  
  get 'logout' => 'users#logout'
  
  get 'dashboard' => 'users#dashboard'
  post 'post' => 'users#post'
  delete 'all_posts' => 'users#destroy_posts'

  get 'profile' => 'users#view'
  get 'all' => 'users#view_all'

  get 'edit' => 'users#edit'
  patch ':user_id' => 'users#change'
  
  get 'check_in' => 'users#attendance'
  post 'check_in' => 'users#check_in'

  delete ':user_id' => 'users#destroy_one'
  delete 'all' => 'users#destroy_all'

  root 'users#login'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
