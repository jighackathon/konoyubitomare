Rails.application.routes.draw do
  resources :project_members
  resources :user_profiles
  resources :user_skills
  devise_for :users
  resources :skills
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
