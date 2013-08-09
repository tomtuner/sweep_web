require 'api_constraints'

Sweep::Application.routes.draw do

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"

	namespace :api, :defaults => {:format => 'json'} do
		scope :module => :v1, :constraints => ApiConstraints.new(:version => 1, :default => true) do
			resources :events
			resources :scans
      resources :customers
      resources :departments
      resources :department_validation
		end
	end
		

 #get "scans/index"
 
	#resources :events
	#resources :scans, :only =>[:create]
  #resources :customers
  #resources :departments
  #resources :department_validation
	resources :users
  resources :sessions
	root :to => 'sessions#new'

end