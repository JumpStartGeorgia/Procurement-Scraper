BootstrapStarter::Application.routes.draw do
	#--------------------------------
	# all resources should be within the scope block below
	#--------------------------------
	scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

		match '/admin', :to => 'admin#index', :as => :admin, :via => :get
		devise_for :users
		namespace :admin do
			resources :users
		end


		match '/process_json', :to => 'root#process_json', :as => :process_json, :via => :get
		root :to => 'root#index'
	  match "*path", :to => redirect("/#{I18n.default_locale}") # handles /en/fake/path/whatever
	end

	match '', :to => redirect("/#{I18n.default_locale}") # handles /
	match '*path', :to => redirect("/#{I18n.default_locale}/%{path}") # handles /not-a-locale/anything

end
