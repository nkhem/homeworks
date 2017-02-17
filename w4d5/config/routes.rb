Rails.application.routes.draw do
  
  get 'thinasfgdn/new'

  get 'thinasfgdn/create'

  get 'thinasfgdn/show'

  resources :users, only: [:index, :new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands
  resources :albums, except: [:index]
  resources :tracks, except: [:index]

end
