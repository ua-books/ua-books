Rails.application.routes.draw do
  # For SEO reasons we want books#show to be as short as possible, thus skipping /books prefix
  get ":id" => "books#show"
end
