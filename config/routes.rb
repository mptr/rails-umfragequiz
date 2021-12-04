Rails.application.routes.draw do
  resources :color_questions
  resources :text_submissions
  resources :text_questions
  resources :submissions
  resources :questions
  resources :submission_sets
  resources :surveys
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
