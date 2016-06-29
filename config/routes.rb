Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/contact" => "pages#join_us"

  resources :roadshows

  get "/research" => "roadshows#research"

  get "/confirmation_creation" => "roadshows#confirmation_creation"


end
