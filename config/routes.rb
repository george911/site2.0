Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" } #新建registrations controller,为了能够注册后重定向到after_signup_path
  scope '(:locale)' do #:locale是插入语，放在path前面，代表了地址里面出现的:locale参数如(en,cn等),
    devise_scope :user do
      get "sign_out", to: "devise/sessions#destroy"
      get "sign_in", to: "devise/sessions#new"
      get "sign_up", to: "registrations#new"
      end
    root 'users#index'
    resources :jobs do
      resources :build, controller: 'jobs/build'
    end
    resources :after_signup
    resources :line_items
    resources :users do
      resources :reviews do #因为需要params[:user_id],所以把路径包含resources :users
        member { post :rating }
	get 'reviews/edit' => :edit
      end
      resources :summaries
    end
  end # end scope '(:locale)'


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
