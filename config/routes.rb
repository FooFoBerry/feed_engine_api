FoofoberryApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects,           only: [:index, :show, :create] do
        resources :commits,          only: [:index, :show]
        resources :repos,            only: [:index, :show, :create]
        resources :tracker_projects, only: [:index, :create]
        resources :tracker_events, only: [:index] 
      end

      resources :repos, only: [:show]
      resources :commits, only: [:create]
      resources :tracker_events, only: [:create]
    end
  end
end
