Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
<<<<<<< Updated upstream
=======
    get 'admin/unauthorized', to: 'admin#unauthorized'
    # resources :users do
    #   collection do
    #     get 'pending_users'
    #     patch 'approve_user'
    #   end
    # end
>>>>>>> Stashed changes
    resources :users do
      member do
        put :approve_user
      end
      collection do
        get :pending_users
      end
    end
  end

  namespace :trader do
    get 'home', to: 'home#index'
  end

  get 'pending_approval', to: 'trader/home#pending_approval'

  resources :stocks, only: [:index]
  resources :user_stocks, only: [:create] do
    collection do
      get 'portfolio'
    end
  end


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
