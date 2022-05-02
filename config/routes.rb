Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :admin_users, ActiveAdmin::Devise.config.merge({
    controllers: ActiveAdmin::Devise.controllers.merge(invitations: "admin/invitations")
  })

  ActiveAdmin.routes(self)

  root "pages#home"
end
