Blabber::Application.routes.draw do
  resources :favorites

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match 'users/auth/:provider/callback', to: 'sessions#create'

  root :to => 'categories#index'

  resources :users

  resources :comments
  match 'comments/:id/vote_up' => 'comments#vote_up', :as => :vote_up_comment
  match 'comments/:id/vote_down' => 'comments#vote_down', :as => :vote_down_comment

  resources :ratings

  get 'events/rating_result'
  match 'events/:id/rate' => 'events#rate', :as => :rate_event
  match 'events/:id/favorite' => 'events#favorite', :as => :favorite_event
  match 'events/favorites' => 'events#favorites', :as => :favorite_events
  match 'events/:id/votes' => 'events#votes'
  resources :events
  match 'events/:id/vote_up' => 'events#vote_up', :as => :vote_up_event
  match 'events/:id/vote_down' => 'events#vote_down', :as => :vote_down_event

  resources :subcategories
  match 'subcategories/:id/events', to: 'subcategories#events', :as => "list_events"

  resources :categories
  match 'categories/:id/subcategories', to: 'categories#subcategories', :as => "list_subcategories"

  match 'contact' => 'contact#index'
  post 'contact/submit_contact'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
