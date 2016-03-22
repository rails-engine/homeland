Rails.application.routes.draw do
  devise_for :users
  mount Homeland::Engine => "/homeland"
  root to: 'welcome#index'
end
