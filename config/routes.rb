Rails.application.routes.draw do
  
  get 'calc_fractions/index'

  get 'calc_fractions/show'

  get 'phase_master/index'

  get 'phase_master/show'

  get 'phase_master/edit'

  get 'phase_master/update'

  get 'project_master/index'

  get 'project_master/show'

  get 'project_master/edit'

  get 'project_master/update'

  get 'pwo_header/index'

  get 'pwo_header/show'

  get 'pwo_header/edit'

  get 'pwo_header/update'

root to: "mems#index"
  
# get 'rollformer_qa_check/update_profiles', as: 'update_profiles'
# get 'rollformer_qa_check/update_pcemarks', as: 'update_pcemarks'
  
match ':controller(/:action(/:id))', :via => [:get, :post]

# get "rollformer_qa_check/:workords/item" => "application#update_profiles", :as => "profiles", :format => :json

# get "pwo_lines/:workords/update_profiles" => "application#update_profiles", :as => "update_profiles", :format => :json
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
  #     resources :products
  #   end
end
