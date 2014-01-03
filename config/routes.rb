Streak::Application.routes.draw do
  resources :goals, except: [:index, :delete] do
    member do
      get :awyea
    end
  end

  root 'goals#new'
end
