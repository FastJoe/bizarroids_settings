Rails.application.routes.draw do

  mount Bizarroids::Settings::Engine => '/admin'

end
