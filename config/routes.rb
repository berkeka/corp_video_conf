Rails.application.routes.draw do
  get 'messages/:id', to: 'message#show'
  get 'conversation', to: 'conversation#index'
  post 'conversation', to: 'conversation#create'
  get '/current_user', to: 'current_user#index'
  mount ActionCable.server => '/cable'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
