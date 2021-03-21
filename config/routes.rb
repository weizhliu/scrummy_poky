Rails.application.routes.draw do
  root 'rooms#index'
  resources :rooms, param: :base, only: %i[index create show] do
    resources :cards, only: :create
    member do
      post :reveal
      post :restart
    end
  end
  resources :users, param: :uuid, only: %i[edit update]
end
