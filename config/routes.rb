FoofoberryApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects,  only: [:index, :show, :create] do
        resources :commits, only: [:index, :show]
        resources :repos,   only: [:index, :show, :create]
      end

      resources :repos, only: [:show]  do
        resources :commits, only: [:create]
      end
    end
  end
end
