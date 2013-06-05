require 'api_constraints'

Sweep::Application.routes.draw do
	
	namespace :api, :defaults => {:format => 'json'} do
		scope :module => :v1, :constraints => ApiConstraints.new(:version => 1, :default => true) do
			resources :events
			resources :scans
		end
	end
		

 #get "scans/index"
 
	resources :events
	resources :scans
	
	root :to => 'scans#index', :as =>'scans'

end