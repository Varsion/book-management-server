Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :accounts, only: [:create, :show]
  resources :books, only: [:index, :show] do
    member do
      get :actual_income
    end
  end
  resources :transactions, only: [:create, :show] do
    collection do
      post :due
    end
  end
end
