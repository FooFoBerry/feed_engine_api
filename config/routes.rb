FoofoberryApi::Application.routes.draw do
  resources :projects, only: [:index, :show, :create] do
    resources :commits, only: [:index]
  end
end
