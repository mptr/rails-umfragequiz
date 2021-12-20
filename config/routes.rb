Rails.application.routes.draw do
  resources :users do
    resources :surveys
  end
  resources :surveys do
    resources :questions
    resources :submission_sets do
      resources :submissions
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
