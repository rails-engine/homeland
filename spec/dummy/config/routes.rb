Dummy::Application.routes.draw do
  root :to => "users#index"
  devise_for :users

  resources :users

  mount Homeland::Engine, :at => "/bbs"
end
