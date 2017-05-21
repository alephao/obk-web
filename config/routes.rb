Rails.application.routes.draw do
  scope '/api' do
    mount_devise_token_auth_for 'Volunteer', at: 'volunteers', skip: [:omniauth_callbacks, :registrations]
    devise_scope :volunteer do
      # Limit registration to only two methds
      resource :registration, only: [:create, :update], path: 'volunteers/sign_up',
                              controller: 'devise_token_auth/registrations', as: :volunteer_registration
    end

    resources :events, only: [:index, :show] do
      member do
        put 'join'
        put 'resign'
      end
    end

    resources :volunteers, only: [:update] do
      member do
        get 'profile'
      end
    end

    namespace :admin do
      mount_devise_token_auth_for 'Admin', at: 'admins', skip: [:registrations, :omniauth_callbacks]
      resources :events
      get 'dashboard/summary', to: 'dashboard#summary', as: :dashboard_summary
    end
  end
end
