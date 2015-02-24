Rails.application.routes.draw do
  devise_for :users

  root 'start#index'

  resources :tasks

  get '/tasks/:id/share', :controller => 'tasks', :action => 'go_share',  :as => 'task_share'
  put '/tasks/:id/share', :controller => 'tasks', :action => 'share'

  get '*path', to: redirect("/404")
end
