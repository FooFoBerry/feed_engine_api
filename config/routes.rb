FoofoberryApi::Application.routes.draw do
  resources :projects,  only: [:index, :show, :create] do
    resources :commits, only: [:index, :show]
    resources :repos,   only: [:index, :show, :create]
  end

  resources :repos do
    resources :commits, only: [:create]
  end
end
