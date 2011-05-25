Bookcamp::Application.routes.draw do
  root :to => 'book_lists#index'

  resources :book_lists, :path => 'listas' do
    get :show_all, :on => :collection, :path => 'camping'
    resources :books, :path => 'libro', :only => [:new]
  end

  resources :books, :path => 'libros' do
    resources :comments
  end

  resources :users, :path => 'colaboradorxs'
  resources :versions, :path => 'actividad'

  match "/auth/:provider/callback" => "sessions#create"
  match "/salir" => "sessions#destroy", :as => :signout
  match "/enter/:id" => "sessions#enter", :as => :enter
end
