Rails.application.routes.draw do
  get "(:slug)/p/:id" => "publishers#show", as: :publisher, constraints: {id: /\d+/}
  get "(:slug)/a/:id" => "authors#show", as: :author, constraints: {id: /\d+/}
  # For SEO reasons we want books#show to be as short as possible, thus skipping /books prefix
  get "(:slug)/:id" => "books#show", as: :book, constraints: {id: /\d+/}
  get "/" => "home#show", as: :root
  get "/:path", to: "static#show", as: :static, constraints: {path: /about|helping-us/}
  get "/sitemap.xml", as: :sitemap, to: "sitemap#show"

  match "/auth/:provider/callback", to: "omniauth_sessions#create",
    as: :omniauth_sessions,
    via: [:get, :post],
    constraints: {provider: Regexp.union(OauthProvider.names.values)}

  namespace :admin do
    get "/" => "home#show", as: :root
    get "/denied", to: "permission_denied#index", as: :permission_denied
    resource :sessions, path: "auth", only: %i[show destroy]
    resources :books
    resources :work_types
    resources :authors
    resources :works
    resources :publishers
    resources :users, only: %i[index]
  end
end
