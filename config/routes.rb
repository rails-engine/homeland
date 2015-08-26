Homeland::Engine.routes.draw do
  root :to => "topics#index"
  get "topics/node_:id", :to => "topics#node", :as => :node_topics
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