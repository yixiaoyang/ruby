SampleApp::Application.routes.draw do
  # 因为 resources :users 不仅使 /users/1 地址可以访问了，而且还为示例程序的 Users 
  # 资源提供了符合 REST 架构的一系列动作5，以及用来获取相应 URL 地址的具名路由（named 
  # route）所以有resources后可以删除get "users/new"
  
  #get "users/new"
  #get "pages/about"
  #get "pages/home"
  #get "pages/contact"

  # add REST resource
  resources :users  
  
  # use named router, 19Oct13
  root to: 'pages#home'
  match '/about',     to: 'pages#about',    via: 'get'
  match '/home',      to: 'pages#home',    via: 'get'
  match '/contact',   to: 'pages#contact',    via: 'get'
  match '/signup',    to: 'users#new',            via: 'get'
  

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
