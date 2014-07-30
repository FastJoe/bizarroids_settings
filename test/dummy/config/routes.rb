Rails.application.routes.draw do

  mount Bizarroids::Settings::Engine => '/admin'

  root to: 'home#index'

end
