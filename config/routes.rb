Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :admin_users, ActiveAdmin::Devise.config.merge({
    controllers: ActiveAdmin::Devise.controllers.merge(invitations: "admin/invitations")
  })

  ActiveAdmin.routes(self)

  root "pages#home"

  get "/admin_users" => "admin/dashboard#index", as: :admin_user_root

  resources :archives, only: %i[index show]
  resources :books, only: %i[index show]
  resources :iconographies, only: %i[index show]
  resources :saviors, only: %i[index show]
  resources :survivors, only: %i[index show]
end
