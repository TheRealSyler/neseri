Rails.application.routes.draw do
  devise_for :users, controllers: {
    invitations: "invitations"
  }

  root 'pages#about'

  get 'impressum',     to: 'pages#impressum'
  get 'privacy',       to: 'pages#privacy'
  get 'contact',       to: 'pages#contact'
  get 'about',         to: 'pages#about'
  get 'documentation', to: 'pages#documentation'
  get 'flashs',        to: 'pages#flashs'

  resources :seminars do
    resource  :clone, controller: 'seminars/clone', only: :create
  end

  namespace :admin do
    resources :settings, only: [:index, :update]
    resources :users, only: [:index, :show]
    resources :emails, only: [:index, :show]
    resources :seminars, only: [:index, :edit, :destroy, :update, :show] do
      resource :admin_copy, controller: 'seminars/admin_copy', only: :create
      resource :lock,       controller: 'seminars/locks',      only: [:create, :destroy]
    end
    resources :seminar_kinds, only: [:index, :new, :create, :destroy, :update]
    resources :rooms, only: [:index, :new, :create, :destroy, :update]
  end

  resource :tos, only: :show
  resource :tos_acceptance, only: :create

  resource :instructor, only: [:show, :edit, :update]
  resolve('Instructor') { :instructor }

  resource :contact_message, only: [:show, :create, :new]
  resolve('contact') { :contact_message }

  resources :rooms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
