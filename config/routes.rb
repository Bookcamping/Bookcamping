Bookcamp::Application.routes.draw do
  root to: redirect('/estanterias')

  # THIS IS PUBLIC
  scope path_names: {new: 'nueva', edit: 'modificar'} do

    # Library
    scope module: 'library' do
      resources :camp_shelves, path: 'estanterias' do
        resources :books, path: 'referencia', only: [:show, :new]
      end
      resources :auto_shelves, path: 'ver', only: [:show]
    end

    # References
    scope module: 'references' do
      resources :books, path: 'referencia', only: [:show, :new] do
        resources :comments, only: [:create]
      end
    end

    scope module: 'public' do
      resources :posts, path: 'blog' do
        resources :comments
      end
    end

    namespace :personal, path: 'mis' do
      root to: redirect('/mis/datos')
      resource :user, path: 'datos'
      resources :books, path: 'referencias'
      resources :user_shelves, path: 'listas'
      resources :profile_shelves, path: 'marcas'
    end


    scope module: 'social' do
      resources :users, path: 'colaboradorxs'
    end

    scope module: 'services' do
      resources :notices, only: [:index]
    end

  end


  namespace :admin do
    root to: 'versions#index'
    resources :versions, path: 'actividad'
    resources :posts, path: 'blog'
    resources :media_bites, path: 'media'
    resources :camp_shelves, path: 'estanterias'
    resources :curated_shelves, path: 'comisariadas'
    resources :notices, path: 'anuncios'
    resources :camps, path: 'campamentos', except: [:create, :destroy]
    resources :books, path: 'referencias'
    resources :comments, path: 'comentarios'
    resources :colors, path: 'colores'
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


  match "/listas" => redirect("/estanterias")
  match "/listas/:id" => redirect("/estanterias/%{id}")
  match "/libros/:id" => redirect("/referencia/%{id}")
  match "/lista/:id" => redirect("/estanteria/%{id}")


  match "/auth/:provider/callback" => "sessions#create"
  match "/salir" => "sessions#destroy", :as => :signout
  match "/buscar/:term" => "books#search", :as => :search
  match "/buscar" => "books#search"
  match "/explorar" => "app#app", :as => :app
  match "/seccion/:id" => "app#section", :as => :section
  match "/entrar/:id" => "sessions#new", :as => :login

  ['mapa', 'cuatrocientoscuatro', 'quinientos'].each do |name|
    match "/#{name}" => "public/screens##{name}"
  end


  # Backdoors used in test and development
  match "/enter/:id" => "sessions#enter", :as => :enter unless Rails.env.production?
  match "/gocamp/:id" => "admin/camps#enter", :as => :gocamp unless Rails.env.production?

end

