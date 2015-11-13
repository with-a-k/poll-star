Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :polls, except: [:index]
    end
  end

  resources :polls, only: [:new, :show, :create]
  get 'polls/:id/vote', to: 'polls#vote', as: 'poll_vote'
  root 'polls#new'
end
