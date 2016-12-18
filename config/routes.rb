Rails.application.routes.draw do
  devise_for :admins
  scope '/api' do
    mount_devise_token_auth_for 'Volunteer', at: 'volunteers', skip: [:omniauth_callbacks, :registrations]
    devise_scope :volunteer do
      # Limit registration to only two methds
      resource :registration, only: [:create, :update], path: 'volunteers/sign_up',
                              controller: 'devise_token_auth/registrations', as: :volunteer_registration
    end

    resources :events
    resources :volunteers, only: [:update] do
      member do
        get 'profile'
      end
    end
  end
end
