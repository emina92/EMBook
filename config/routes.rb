Rails.application.routes.draw do
 
  resources :activities, only: [:index]

  get 'profiles/show'

 
  devise_for :users, :controllers => {:registrations => "registrations"}

  devise_scope :user do
    get 'register',  to: "devise/registrations#new", as: :register
    get 'login',  to: "devise/sessions#new", as: :login
    get 'logout',  to: "devise/sessions#destroy", as: :logout
  end

  resources :user_friendships do
    member do
      put :accept
      put :block
    end
  end
  resources :statuses do
    resources :comments, module: :statuses
  end
  root to: 'statuses#index'

  get '/:id', to: 'profiles#show', as: "profile"
  
  scope ":profile_name" do
    resources :albums do
      resources :comments, module: :albums
      resources :pictures do
        resources :comments, module: :pictures
      end
    end
  end 


end
