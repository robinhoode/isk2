
Isk::Application.routes.draw do
  root 'search#index'
  get   '/search' => 'search#index'
  post  '/search' => 'search#query', as: :submit_search
  get   '/search/advanced' => 'search#advanced', as: :advanced_search
  resources :titles
  resources :authors
  resources :books do
    get :sold, on: :member
  end
end
