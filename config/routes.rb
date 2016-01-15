Rails.application.routes.draw do
  root to: "issue_reports#index", :path => 'problemas'

  resources :issues, :path => 'categorias'
  get "/problemas_resolvidos", to: 'issue_reports#resolvidos', as: :issue_reports_resolvidos
  resources :issue_reports, :except => [:new, :create], :path => 'problemas' do
    resources :resolution_report, :only => [:new, :create, :destroy]
  end

  devise_for :users, path: "/", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  use_doorkeeper
  mount API::Base => '/'
end
