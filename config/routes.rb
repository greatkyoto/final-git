Rails.application.routes.draw do
  root to:"memos#index"
  get "/new", to:"memos#new"
  post "/create", to:"memos#create"
  delete "/destroy", to:"memos#destroy"
end
