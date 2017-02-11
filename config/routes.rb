Rails.application.routes.draw do
  devise_for :users
  telegram_webhooks TelegramWebhooksController

  namespace :admin do
    resources :users
    resources :creatures
    resources :traps
  end

  root to: "admin/users#index"
end
