# encoding: utf-8
Bookcamp::Application.routes.draw do

  root to: "camp_shelves#index"

  # THIS IS PUBLIC
  scope path_names: {new: 'nueva', edit: 'modificar'} do

    # Camp Shelves
    resources :camp_shelves, path: 'estanterias' do
      scope module: 'camp_shelves' do
        resources :books, path: 'referencia', only: [:show, :new] do
          get :select, on: :collection, path: 'buscar'
          post :add, on: :member, path: 'anadir'
        end
        resources :auto_shelves, path: 'ver', only: [:show]
      end
    end

    # User Shelves
    resources :user_shelves, path: 'listas' do
      scope module: 'user_shelves' do
        resources :books, path: 'referencias', only: [:show, :new] do
          get :select, on: :collection, path: 'buscar'
          post :add, on: :member, path: 'anadir'
        end
      end
    end

    # References
    scope module: 'references' do
      resources :books, path: 'referencia' do
        resources :comments, only: [:create]
        resources :shelf_items, path: 'listas'
        resources :taggings
      end
    end

    resources :tags
    resources :versions, path: 'actividad' do
      get :email, on: :collection
    end
    resources :publishers, path: 'editoriales'

    scope module: 'licenses' do
      resources :licenses, path: 'licencias'
    end

    scope module: 'public' do
      resources :password_recoveries, path: 'recuperar', except: [:index] do
        post :change, on: :collection
      end
    end
    match '/recuperar/token/:id' => 'public/password_recoveries#recover', as: 'recovery'
    resources :pages, path: 'wiki'

    ['agradecimientos', 'contactar', 'nosotras', 'colofon', 'como', 'visitas'].each do |name|
      match name => "public/info_pages##{name}"
    end

    resources :users, path: 'somos' do
      scope module: 'social' do
        get :search, on: :collection, path: 'buscar'

        resources :versions, path: 'actividad'
        resources :user_shelves, path: 'listas', only: [:index, :show] do
          resources :books, path: 'referencias', only: [:show, :index]
        end
      end
    end
  end

  scope module: 'blog' do
    resources :posts, path: 'blog' do
      resources :comments
    end
    resources :media_bites, path: 'media'
  end

  namespace :admin do
    root to: 'camp_shelves#index'
    resources :camp_shelves, path: 'estanterias'
    resources :curated_shelves, path: 'comisariadas'
    resources :notices, path: 'anuncios'
    resources :camps, path: 'campings'
    resources :books, path: 'referencias'
    resources :comments, path: 'comentarios'
    resources :colors, path: 'colores'
    resources :users, path: 'somos'

    resources :identities, except: [:create, :destroy]
  end

  match "/clismon/pnh" => 'publishers/clismon#pnh'

  match "/identificar" => "public/sessions#create"
  match "/entrar" => "public/sessions#new", as: :login
  match "/auth/:provider/callback" => "public/sessions#create_with_omniauth"
  match "/salir" => "public/sessions#destroy", :as => :logout
  match "/entrar/:id" => "public/sessions#new", :as => :auth
  match "/auth/failure" => "public/sessions#failure"

  match "/buscar/:term" => "references/books#search", :as => :search
  match "/buscar" => "references/books#search"

  ['mapa', 'cuatrocientoscuatro', 'quinientos', 'sopa'].each do |name|
    match "/#{name}" => "public/screens##{name}"
  end

  # Backdoors used in test and development
  match "/enter/:id" => "public/sessions#enter", :as => :enter unless Rails.env.production?
  match "/gocamp/:id" => "admin/camps#enter", :as => :gocamp

end

