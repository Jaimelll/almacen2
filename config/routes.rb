Rails.application.routes.draw do


  resources :products
  resources :formulas
  resources :clients
  resources :parameters
  resources :items
  resources :details


  devise_for :users, ActiveAdmin::Devise.config


  ActiveAdmin.routes(self)



#root 'welcome#index'
root 'admin/dashboard#index'
match 'variables/form', via: [:get]
match 'variables/comment', via: [:get]
match 'reports/vhoja1', via: [:get]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
