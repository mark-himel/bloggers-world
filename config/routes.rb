Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'blogs#index'
  resources :blogs, except: %i(edit update destroy) do
    member do
      resources :comments, only: %i(new create)
    end
  end
end
