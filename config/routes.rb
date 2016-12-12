Rails.application.routes.draw do
  devise_for :admins, :volunteers
  scope '/api' do
    resources :events
    resources :volunteers
  end
end
