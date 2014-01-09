FoofoberryApi::Application.routes.draw do
  resources :projects, only: [:index, :show, :create]
end
