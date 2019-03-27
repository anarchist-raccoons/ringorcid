Rails.application.routes.draw do
  resources :orcids, only: [:index, :show]
  
  root 'orcids#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post "ringgold_query", to: "orcids#ringgold_query"
  post "grid_query", to: "orcids#grid_query"
  
end
