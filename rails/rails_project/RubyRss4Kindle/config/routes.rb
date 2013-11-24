RubyRss4Kindle::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  
  root to: 'pages#home'
  match '/about',     to: 'pages#about',      via: 'get'
  match '/home',      to: 'pages#home',       via: 'get'
  match '/contact',   to: 'pages#contact',    via: 'get'
  match '/not_found',   to: 'pages#404',      via: 'get'
  
  # add REST resource,响应get，得到类似 /users/1/following 和 /users/1/followers的url
  resources :users do
    member do
      get :following, :friends
    end
  end
 
  # 没必要显示或编辑 session，为 resources 方法指定:only 选项new、create 和 destroy 动作
  resources :sessions, only:[:new, :create, :destroy]
  
  resources :channels do
    get :followed
  end
  
  match '/signup',    to: 'users#new',        via: 'get'
  match '/signin',    to: 'sessions#new',     via: 'get'
  match '/signout',   to: 'sessions#destroy',     via: 'delete'
  
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
