Homeland::Engine.routes.draw do
  root to: 'topics#index'
  get 'node/:id', to: 'topics#node', as: :node_topics
  resources :topics, path: 't' do
    member do
      post :reply
    end
    collection do
      get :recent
      get :features
    end
  end
end
