Homeland::Engine.routes.draw do
  resources :topics do
    member do
      post :reply
    end
    collection do
      get :node
      get :search
      get :feed
      get :recent
    end
  end
  resources :replies
end