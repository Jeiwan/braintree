Rails.application.routes.draw do
  resources :payments, only: [:index] do
    collection do
      get 'token'
      post 'checkout'
    end
  end

  root 'payments#index'
end
