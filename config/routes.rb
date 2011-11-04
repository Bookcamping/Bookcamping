Bookcamp::Application.routes.draw do
  root :to => 'camp_shelves#index'

  # THIS IS PUBLIC
  scope :path_names => {:new => 'nueva', :edit => 'modificar'} do
    resources :camp_shelves, :path => 'listas' do
      resources :books, :path => 'referencia', :only => [:show, :new]
    end

    resources :licenses, :path => 'licencias'

    resources :books, :path => 'referencia' do
      get :view, :on => :member
      resources :comments
      resources :shelf_items, :path => 'incluidos'
      resources :bookmarks, :path => 'marcar'
    end

    resources :posts, :path => 'blog'

    resources :users, :path => 'colaboradorxs'
    resources :versions, :path => 'actividad'

    resources :notices, only: [:index]
  end

  namespace :admin do
    root to: 'versions#index'
    resources :versions, path: 'actividad'
    resources :posts, path: 'blog'
    resources :media_bites, path: 'media'
    resources :camp_shelves, path: 'listas'
    resources :curated_shelves, path: 'comisariadas'
    resources :notices, path: 'anuncios'
    resources :camps, :path => 'campamentos', except: [:create, :destroy]
  end

  namespace :personal, path: 'mi' do
    root to: redirect('/mi/perfil')
    resource :user, path: 'perfil'
    resources :books, path: 'biblioteca'
    resources :user_shelves, path: 'estanterias'
  end

  namespace :backend do
    root to: 'stats#show'
    resource :stats
    resources :licenses
    resources :books
    resources :users
    resources :posts
    resources :shelves
    resources :versions
  end


  match "/libros/:id" => redirect("/referencia/%{id}")

  match "/mapa" => 'maps#show'

  match "/lista/:id" => "shelves#auto", :as => :autoshelf
  match "/auth/:provider/callback" => "sessions#create"
  match "/salir" => "sessions#destroy", :as => :signout
  match "/enter/:id" => "sessions#enter", :as => :enter unless Rails.env.production?
  match "/gocamp/:id" => "camps#enter", :as => :gocamp
  match "/buscar/:term" => "books#search", :as => :search
  match "/buscar" => "books#search"
  match "/explorar" => "app#app", :as => :app
  match "/seccion/:id" => "app#section", :as => :section
  match "/entrar/:id" => "sessions#new", :as => :login
end

