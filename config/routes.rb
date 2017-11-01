Rails.application.routes.draw do
  mount API => '/api'
  root 'hands#index'
  get 'hands/index'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
