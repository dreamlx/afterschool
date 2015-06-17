Rails.application.routes.draw do
  get 'tools/import_students'
  post 'tools/do_import_students'

  resources :articles

  devise_for :users
  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      get 'work_papers', to: 'work_papers#index'
      get 'work_papers/:work_paper_id/home_works', to: 'home_works#index'

      get 'media', to: 'media_resources#index'
      post 'media/search', to: 'media_resources#search'


      resources :work_papers do
        resources :media_resources
        resource :work_review
      end

      resources :home_works do
        resources :media_resources
        resource :work_review
        collection do
          get 'un_review'
        end
      end

      resources :users do
        resource :profile do
          post 'replace_avatar'
        end
      end

      resources :teachers do
        resources :work_reviews do
          collection do
            post 'batch_review'
          end
        end
        resource :profile
        resources :work_papers, shallow: true
        resources :school_classes
        resources :informs
        resources :votes do
          member do
            post 'choose'
            post 'close'
          end
        end
        # resources :voteOptions
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

      resources :user_messages, only: [:index, :show]

      resources :posts do
        resources :comments
      end
    end
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'home#index'

end
