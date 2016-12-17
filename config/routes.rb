Rails.application.routes.draw do
  devise_for :admins
  scope '/api' do
    mount_devise_token_auth_for 'Volunteer', at: 'auth'

    resources :events
    resources :volunteers
  end
end
