Bookcamp::Application.routes.draw do
  root :to => 'shelves#index'

  match "/reticula" => "shelves#browse", :as => :browse
  match "/estadisticas" => "books#statistics", :as => :statistics

  resources :shelves, :path => 'listas' do
    resources :books, :path => 'referencia', :only => :show
  end

  resources :camps, :path => 'campamentos'
  resources :licenses, :path => 'licencias'

  resources :books, :path => 'referencia' do
    get :view, :on => :member
    resources :comments
    resources :shelf_items, :path => 'incluidos'
    resources :bookmarks, :path => 'marcar'
  end

  resources :users, :path => 'colaboradorxs'
  resources :versions, :path => 'actividad'

  match "/libros/:id" => redirect("/referencia/%{id}")


  match "/lista/:id" => "shelves#auto", :as => :autoshelf
  match "/auth/:provider/callback" => "sessions#create"
  match "/salir" => "sessions#destroy", :as => :signout
  match "/enter/:id" => "sessions#enter", :as => :enter
  match "/gocamp/:id" => "camps#enter", :as => :gocamp
  match "/buscar/:term" => "books#search", :as => :search
  match "/buscar" => "books#search"
  match "/explorar" => "app#app", :as => :app
  match "/seccion/:id" => "app#section", :as => :section
end
