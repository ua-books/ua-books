Rails.application.routes.draw do
  # For SEO reasons we want books#show to be as short as possible, thus skipping /books prefix
  get "(:slug)/:id" => "books#show", as: :book, constraints: {id: /\d+/}
  get "/" => "home#show", as: :root

  namespace :admin do
    resources :books
    resources :work_types
  end
end
