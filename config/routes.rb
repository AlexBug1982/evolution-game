Rails.application.routes.draw do
  root "welcome#index"
  get 'welcome/index'

  get '/404', to: 'errors#not_found', via: :all
  get '/422', to: 'errors#unacceptable', via: :all
  get '/500', to: 'errors#internal_error', via: :all

  get '/signup_player', to: "player#index"
  post '/signup_player', to: "player#create_player"

  authenticate :admin_user do
    require 'sidekiq/web'
    require 'sidecloq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) unless ARGV.grep(/assets:(precompile|clean)/).any?
end
