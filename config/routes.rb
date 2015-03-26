Rails.application.routes.draw do
  resources :articles

  devise_for :users
  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do 
    namespace :v1 do 
      get 'work_papers', to: 'work_papers#index'
      get 'work_papers/:id/home_works', to: 'home_works#index'

      resources :work_papers do
        resources :media_resources
        resource :work_review
      end

      resources :home_works do
        resources :media_resources
        resource :work_review
      end

      resources :users do
        resource :profile do
          post 'replace_avatar'
        end
      end

      resources :teachers do
        resources :work_reviews
        resource :profile
        resources :work_papers, shallow: true
        member do
          post 'send_message_to_person'
          post 'send_message_to_class'
          get 'user_messages'
        end
      end
      
      resources :students do
        resource :profile
        resources :work_papers, shallow: true
        resources :home_works, shallow: true
        member do
          post 'send_message_to_person'
          post 'send_message_to_class'
          get 'user_messages'
        end
      end
      
      
      resources :user_tokens
      resources :school_classes do
        resources :work_papers, shallow: true
        resources :students
        resources :teachers
      end
    end
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'home#index'
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
