Bookcamp::Application.routes.draw do
  root :to => 'shelves#browse'
  match "/reticula" => "shelves#browse", :as => :browse

  resources :shelves, :path => 'listas' do
    resources :books, :path => 'libro', :only => [:new, :create]
    resources :shelf_items, :path => 'incluidos' do
      get :autocomplete_book_title, :on => :collection
    end
  end

  resources :camps, :path => 'campamentos'

  resources :books, :path => 'libros' do
    get :view, :on => :member
    resources :comments
    resources :shelf_items, :path => 'incluidos'
  end

  resources :users, :path => 'colaboradorxs'
  resources :versions, :path => 'actividad'

  match "/auth/:provider/callback" => "sessions#create"
  match "/salir" => "sessions#destroy", :as => :signout
  match "/enter/:id" => "sessions#enter", :as => :enter
  match "/gocamp/:id" => "camps#enter", :as => :gocamp
end
