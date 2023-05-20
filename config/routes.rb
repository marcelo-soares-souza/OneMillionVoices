# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /pt-BR|es|en|fr|gl/ do
    root to: "home#index"
    get "home/index"
  end

  get "/map", to: "home#index"
  get "/about", to: "about#index"
  get "/who_we_are", to: "about#who_we_are"
  get "/manual", to: "about#manual"
  get "license", to: "about#license"

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
    resources :midias
    get "/gallery" => "midias#gallery"
  end

  resources :locations do
    get "/gallery" => "midias#gallery"
    resources :practices
    resources :midias
  end

  devise_for :accounts, controllers: {
    registrations: "accounts/registrations"
  }

  resources :accounts do
    resources :locations
    resources :practices
  end
end
