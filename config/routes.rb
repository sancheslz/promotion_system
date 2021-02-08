Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :promotions, only: %i[index show new create edit update destroy] do
    get 'delete', on: :member
    get 'generate_coupons', on: :member
  end
  
  resources :coupons, only: %i[] do
    get 'inactivate', on: :member
    get 'activate', on: :member
  end
  
end
