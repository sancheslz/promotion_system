Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'search', to: 'home#search'
  
  resources :promotions, only: %i[index show new create edit update destroy] do
    get 'delete', on: :member
    get 'generate_coupons', on: :member
    get 'approve', on: :member
  end
  
  resources :coupons, only: %i[] do
    get 'inactivate', on: :member
    get 'activate', on: :member
  end

  resources :categories, only: %i[index show new create edit update]
  
end
