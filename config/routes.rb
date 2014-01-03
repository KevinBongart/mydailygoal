Streak::Application.routes.draw do
  resources :goals, except: [:index] do
    member do
      get :awyea
    end
  end

  root 'goals#new'
end
