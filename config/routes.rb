Rails.application.routes.draw do
  root to: "user_profile#show"

  resources :issues
  resources :issue_reports, :except => [:new, :create] do
    # get 'resolution_report/new'
    # post 'resolution_report/create'
    resources :resolution_report, :only => [:new, :create, :destroy]
  end

  devise_for :users
  use_doorkeeper
  mount API::Base => '/'
end
