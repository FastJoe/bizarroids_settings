Bizarroids::Settings::Engine.routes.draw do
  resources :options, only: %i(index edit update)
end
