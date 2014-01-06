Streak::Application.routes.draw do
  resources :goals do
    member do
      get :awyea
    end
  end

  root 'goals#new'
end
