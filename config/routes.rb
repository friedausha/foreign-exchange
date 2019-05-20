Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rate_history, path: :history
  resources :exchangeable_currency, path: :currency

  get '/history/index/:date' => 'rate_history#index'
end