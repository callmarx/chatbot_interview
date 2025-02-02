Rails.application.routes.draw do
  root "candidates#index"
  resources :candidates, only: [:create]
  get "chat/:candidate_id", to: "chat#show", as: "chat"
  post "chat/:candidate_id", to: "chat#create"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
