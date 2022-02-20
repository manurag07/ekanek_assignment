Rails.application.routes.draw do
  root to: 'blogs#index'
  resources :blogs
  devise_for :users
  get '/:id' => 'shortener/shortened_urls#show'
  get 'blog/:id', to: 'blogs#blog_from_url'
end
