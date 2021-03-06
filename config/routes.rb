Rails.application.routes.draw do
  
  get 'about' => 'static#about'

  get 'static/businesses'

  resources :charges
  
  resources :rewardpurchases do
    member do
      post 'redeem'
    end
  end
  get 'valid' => 'static#valid'
  get 'signup' => 'static#bizsignup'

  get 'myrewards' => 'rewardpurchases#myrewards'
  get 'rewardpurchases/:id' => 'rewardpurchase#show'
  get 'ourrewards' => 'rewards#myrewards'

  resources :courses do
    member do
      post 'enroll'
    end
  end 
  resources :enrolls
  resources :subjects
  devise_for :businesses, controllers: { registrations: 'businesses/registrations' }

  resources :rewards do
    member do
      post 'rewardpurchase'
    end
  end
  devise_for :users
  root 'static#home'
  
  resources :flags
  get 'flagged' => "flags#flagged"
  get 'flag' => "flags#flags"
  resources :hides
  get 'hidden' => "hides#hidden"
  get 'hide' => "hides#hides"

  resources :posts do
    resources :comments
  end
  
  resources :posts do
    resources :comments do
      member do
        put "like",    to:"comments#upvote"
        put "dislike", to:"comments#downvote"
        post 'hide'
      end
    end
    member do
      put "like",    to:"posts#upvote"
      put "dislike", to:"posts#downvote"
      post 'flag'
    end
  end
  resources :universities
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #  root 'welcome#index'

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
