Rails.application.routes.draw do
  get 'welcome/index'
  get 'competitors/find_info'

  resources :competitor



  root 'welcome#index'

end
