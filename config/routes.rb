Bizarroids::Settings::Engine.routes.draw do
  scope module: :bizarroids do
    scope module: :settings do
      resources :options, only: %i(index edit update)
    end
  end
end
