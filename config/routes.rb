# frozen_string_literal: true

Rails.application.routes.draw do
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

  resources :about
  resources :who_we_are
  resources :manual

  scope "(:locale)", locale: /pt-BR|es|en|fr|gl/ do
    root to: "home#index"
    get "home/index"
  end

  get "/map", to: "home#index"

  resources :agroecological_practices
  resources :agroecological_practices do
    get "/gallery" => "midias#gallery"
    resources :midias
  end

  scope(locais: {}) do
    resources :locais, path: "locations"
  end

  resources :locais do
    get "/gallery" => "midias#gallery"
    resources :agroecological_practices
    resources :practices
    resources :midias
  end

  scope(usuarios: {}) do
    resources :usuarios, path: "accounts"
    resources :usuarios, path: "contributors"
  end

  #  devise_for :usuarios
  devise_for :usuarios, controllers: {
    registrations: "usuarios/registrations"
  }

  resources :usuarios do
    resources :locais
    resources :agroecological_practices
    resources :practices
  end
end
