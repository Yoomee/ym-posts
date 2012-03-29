Rails.application.routes.draw do
  
  resources :posts do
    member do
      get :modal
    end
  end
  
end
