require 'api_constraints'

Sweep::Application.routes.draw do

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  
  get "password" => "password_resets#index"
  
  # get '/department_validation#index', to: 'department_validation#create'

	namespace :api, :defaults => {:format => 'json'} do
    # Make sure default one is last in the list!
		scope :module => :v2, :constraints => ApiConstraints.new(:version => 2) do
			resources :events
			resources :scans do
        collection do
          post 'registration'
        end
      end
      resources :users
      resources :customers
      resources :departments
      resources :department_validation
      # resources :user_registration
      get 'department_validation/create', to: 'department_validation#index'
		end
		scope :module => :v1, :constraints => ApiConstraints.new(:version => 1, :default => true) do
			resources :events
			resources :scans
      resources :customers
      resources :departments
      resources :department_validation
      get 'department_validation/create', to: 'department_validation#index'
		end
	end
		
  resources :welcome
  resources :profile
  resources :dashboard
  resources :confirm_email
  resources :events, only: [:index, :show, :new, :create]
	#resources :scans, :only =>[:create]
  resources :customers, only: [:new, :create]
  resources :departments, only: [:index, :show, :create, :new]
  #resources :department_validation
  resources :advisors, only: [:create, :new, :destroy]
  resources :admin
  resources :accounts
  resources :password_resets
  resources :users
  resources :sessions
  root :to => 'dashboard#index'
end