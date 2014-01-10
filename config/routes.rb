FoofoberryApi::Application.routes.draw do
  resources :projects,  only: [:index, :show, :create] do
    resources :commits, only: [:index, :show, :create]
    resources :repos,   only: [:index, :show]
  end
end
