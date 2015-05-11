Rails.application.routes.draw do

  get 'lectures', to: 'lectures#index'
  get 'lectures/:id', to: 'lectures#show'
  get 'lectures/new', to: 'lectures#new'
  get 'lectures/:id/edit', to: 'lectures#edit'
  post 'lectures', to: 'lectures#create'
  delete 'lectures/:id', to: 'lectures#destroy'
  patch 'lectures/:id', to: 'lectures#update'



  get 'lectures/:lecture/tasks', to: 'tasks#index'
  get 'lectures/:lecture/tasks/new', to: 'tasks#new'
  get 'lectures/:lecture/tasks/:id', to: 'tasks#show'
  get 'lectures/:lecture/tasks/:id/edit', to: 'tasks#edit'
  post 'lectures/:lecture/tasks', to: 'tasks#create'
  delete 'lectures/:lecture/tasks/:id', to: 'tasks#destroy'
  patch 'lectures/:lecture/tasks/:id', to: 'tasks#update'


  get 'lectures/:lecture/tasks/:task/solutions', to: 'solutions#index'
  get 'lectures/:lecture/tasks/:task/solutions/new', to: 'solutions#new'
  get 'lectures/:lecture/tasks/:task/solutions/:id', to: 'solutions#show'
  get 'lectures/:lecture/tasks/:task/solutions/:id/edit', to: 'solutions#edit'
  post 'lectures/:lecture/tasks/:task/solutions', to: 'solutions#create'
  delete 'lectures/:lecture/tasks/:task/solutions/:id', to: 'solutions#destroy'
  patch 'lectures/:lecture/tasks/:task/solutions/:id', to: 'solutions#update'
end
