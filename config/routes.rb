Rails.application.routes.draw do
  root to: "user_profile#show"

  resources :issues
  resources :issue_reports, :except => [:new, :create]

  devise_for :users
  use_doorkeeper
  mount API::Base => '/'
end
