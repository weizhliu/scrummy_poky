Rails.application.routes.draw do
  root 'rooms#index'
  resources :rooms, param: :base, only: %i[index create show]
  resources :users, param: :uuid, only: %i[edit update]
end
