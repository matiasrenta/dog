Rails.application.routes.draw do

  resources :promotions
  resources :inventory_events
  resources :inventories
  resources :boxes
  resources :product_brands
  resources :mix_box_details
  resources :product_prices
  resources :customer_categories
  resources :purchase_orders, shallow: true do
    resources :purchase_order_details
  end
  resources :suppliers
  resources :orders, shallow: true do
    resources :order_details
    get :ajax_get_info_from_promotion, on: :collection
    get :ajax_get_info_from_product, on: :collection
    get :ajax_get_info_from_box, on: :collection
  end

  resources :customers, shallow: true do
    resources :customer_branches
    resources :customer_contacts
  end
  resources :products
  resources :dashboard
  resources :social_users
  resources :api_keys
  resources :comments
  resources :conversations, only: [:index, :show, :destroy] do
    post :mark_as_read, on: :member
    get :mark_all_as_read, on: :collection
  end
  resources :delayed_jobs
  resources :thing_categories
  resources :wizard
  resources :public_activity
  resources :thing_contacts
  resources :thing_parts
  resources :things do
    collection do
      get 'new_import'
      post 'create_import'
      get 'download_import_file'
    end
  end

  namespace :dynamic_select do
    get ':thing_id/thing_contacts', to: 'thing_contacts#index', as: 'thing_contacts' # el as: es para que el helper method sea 'dynamic_select_thing_contacts_path' y no 'dynamic_select_path'
    get ':customer_id/customer_branches', to: 'customer_branches#index', as: 'customer_branches' # el as: es para que el helper method sea 'dynamic_select_thing_contacts_path' y no 'dynamic_select_path'
    get ':event_id/inventory_reasons', to: 'inventory_reasons#index', as: 'inventory_reasons' # el as: es para que el helper method sea 'dynamic_select_thing_contacts_path' y no 'dynamic_select_path'
    get ':product_id/product_boxes', to: 'product_boxes#index', as: 'product_boxes' # el as: es para que el helper method sea 'dynamic_select_thing_contacts_path' y no 'dynamic_select_path'
  end

  namespace :dev do
    resources :catalog_cleaners do
      post :run_cleaner, on: :collection
    end
    resources :chucky_bots
    resources :examples do
      collection do
        get 'chartkick'
        get 'cors'
      end

    end
  end

  namespace :admin do
    root to: 'application#index'
    resources :settings
  end

  devise_for :users
  resources :users do
    get 'resend_password_instructions/:id', action: 'resend_password_instructions', on: :collection
    get 'mentionables', on: :collection
  end

  devise_for :api_users, controllers: { registrations: 'api_users/registrations', confirmations: 'api_users/confirmations', passwords: 'api_users/passwords' }
  resources :api_users do
    get 'error_when_confirmation', to: 'api_users/welcome#error_when_confirmation', on: :collection
    get 'check_credentials', to: 'api_users/welcome#check_credentials', on: :collection
  end
  get 'api_user_root', to: 'api_users/welcome#welcome'


  get "application/access_denied"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Rout para probar paginas
  get 'welcome/prueba'

  # You can have the root of your site routed with "root"
  root to: 'dashboard#index'

  #match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #
  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     #   end




end
