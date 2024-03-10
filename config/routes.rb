Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/users/signup', to: 'users#signup'
      post '/users/signin', to: 'users#signin'
    end
  end
end
