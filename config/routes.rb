Rails.application.routes.draw do
  # TODO
  resources :single_choice_questions
  resources :multiple_choiche_questions
  resources :likert_questions
  resources :prio_questions
  resources :multiple_number_submissions
  resources :rearrangeable_questions
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
