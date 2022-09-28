Rails.application.routes.draw do
  devise_for :users,skip: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post '/new_user', to: 'registrations#create'
        get '/confirmation', to: 'confirmations#show'
        get '/send_confirmation', to: 'confirmations#resend_email'
        post '/google', to: 'authentications#google'
        post '/sign-in', to: 'authentications#sign_in'
        get '/sign-out', to: 'authentications#sign_out'
      end
    end
  end
end
