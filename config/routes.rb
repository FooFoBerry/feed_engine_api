FoofoberryApi::Application.routes.draw do
  resources :users, only: [:index, :create]
end
