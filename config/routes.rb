Actionman::Application.routes.draw do

  ActiveAdmin.routes(self)

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  match "search" => "search#index"
  match "counts" => "counts#index"
  match 'member/idea_actions' => 'member#idea_actions'

	resources :members, only: [:update]

  resources :idea_actions do
    collection do
      get 'random'
    end

    member do
      put 'complete'
    end
  end

  resources :ideas do
    resources :idea_actions
    collection do
      get 'random'
    end

    member do
      get 'show_idea_url'
    end
  end

  resources :events do
    member do
      get 'ideas'
    end

    resources :talks do
      resources :ideas
    end
  end

  resources :talks

  resources :member_sessions do
    collection do
      get 'check'
      delete 'logout'
    end
  end

  get "welcome/index"

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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"
  mount JasmineRails::Engine => "/specs" if Rails.env.development? or Rails.env.test?

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
