Rails.application.routes.draw do
  
  resources :posts do
    member do
      get :file
      get :modal
    end
  end
  resources :comments, :only => [:create]
  
end
