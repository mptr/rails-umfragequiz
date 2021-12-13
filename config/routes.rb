Rails.application.routes.draw do
  resources :string_questions
  resources :slider_questions
  resources :number_questions
  resources :number_range_questions
  resources :nps_questions
  resources :number_submissions
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
