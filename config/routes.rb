# frozen_string_literal: true

Rails.application.routes.draw do
  get "errors/not_found"
  get "errors/internal_server_error"
  resources :documents
  scope "(:locale)", locale: /pt-BR|es|en|fr|gl/ do
    root to: "home#index"
    get "home/index"
  end

  get "map", to: "home#map"
  get "landing", to: "about#landing"
  get "about", to: "about#index"
  get "who_we_are", to: "about#who_we_are"
  get "manual", to: "about#manual"
  get "license", to: "about#license"
  get "thank_you_notes", to: "about#thank_you_notes"

  resources :practices
  resources :acknowledges
  resources :evaluates
  resources :characterises
  resources :what_you_dos

  resources :practices do
    resources :acknowledges
    resources :evaluates
    resources :characterises
    resources :what_you_dos
    resources :medias
    resources :documents
    get "/gallery" => "medias#gallery"
  end

  resources :locations do
    get "/gallery" => "medias#gallery"
    resources :practices
    resources :medias
    resources :documents
  end

  devise_for :accounts, controllers: {
    registrations: "accounts/registrations", sessions: "accounts/sessions"
  }

  resources :accounts do
    resources :locations
    resources :practices
  end

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  match "/422", to: "errors#unprocessable_entity", via: :all
end
