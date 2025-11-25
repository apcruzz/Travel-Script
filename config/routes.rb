Rails.application.routes.draw do
  resource :session, only: [ :create, :destroy ]
  resources :users, except: [ :new ]
  resources :passwords, param: :token
  resources :trips do
    resources :journal_entries do
      post "react", to: "reactions#create"
      patch "react", to: "reactions#update"  # change reaction type
      delete "unreact", to: "reactions#destroy"
    end
  end
  # get "sites/index" why do we have to delete? this line?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # get "/Login", to: redirect("/login") # Redirect capitalized URL to lowercase error from nav_link
  # get "/Sign Up", to: redirect("/signup")

  get "about" => "sites#about"
  get "login" => "sessions#new"
  get "signup" => "users#new"
  get "/auth/:provider/callback" => "authentications#create"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

   # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
   # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
   # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

   # Defines the root path route ("/")
   root "sites#index"
end
