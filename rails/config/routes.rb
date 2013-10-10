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
			resources :scans
      resources :customers
      resources :departments
      resources :department_validation
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
		

 #get "scans/index"
 
  resources :events, only: [:index, :show]
	#resources :scans, :only =>[:create]
  resources :customers, only: [:new, :create]
  resources :departments
  #resources :department_validation
  resources :advisors
  resources :admin
  resources :accounts
  resources :password_resets
  resources :users
  resources :sessions
  root :to => 'accounts#index'
end