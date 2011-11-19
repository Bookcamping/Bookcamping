Bookcamp::Application.routes.draw do

  root to: "library/camp_shelves#index"

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
      resources :books, path: 'referencia' do
        resources :comments, only: [:create]
        resources :shelf_items, path: 'listas'
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
      resources :user_shelves, path: 'listas' do
        post :bulk_add, on: :collection
      end
      resources :profile_shelves, path: 'marcas'
    end


    scope module: 'social' do
      resources :users, path: 'somos', only: [:index, :show] do
        resources :user_shelves, path: 'listas', only: [:show] do
          resources :books, path: 'referencias', only: [:show, :index]
        end
      end
      resource :explorer, path: 'explorar', only: [:show]
    end

    scope module: 'services' do
      resources :notices, only: [:index]
    end

  end


  namespace :admin do
    root to: 'versions#index'
    resources :versions, path: 'actividad'
    resources :camp_shelves, path: 'estanterias'
    resources :curated_shelves, path: 'comisariadas'
    resources :notices, path: 'anuncios'
    resources :camps, path: 'campings', except: [:create, :destroy]
    resources :books, path: 'referencias'
    resources :comments, path: 'comentarios'
    resources :colors, path: 'colores'

    scope module: 'blog' do
      resources :posts, path: 'blog'
      resources :media_bites, path: 'media'
      #Mercury::Engine.routes
    end
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

  match "/clismon/pnh" => 'publishers/clismon#pnh'


  match "/listas" => redirect("/estanterias")
  match "/listas/:id" => redirect("/estanterias/%{id}")
  match "/libros/:id" => redirect("/referencia/%{id}")
  match "/lista/:id" => redirect("/estanteria/%{id}")


  match "/entrar" => "public/sessions#new", as: :login
  match "/auth/:provider/callback" => "public/sessions#create"
  match "/salir" => "public/sessions#destroy", :as => :logout
  match "/entrar/:id" => "public/sessions#new", :as => :auth
  match "/auth/failure" => "public/sessions#failure"

  match "/buscar/:term" => "references/books#search", :as => :search
  match "/buscar" => "references/books#search"

  ['mapa', 'cuatrocientoscuatro', 'quinientos'].each do |name|
    match "/#{name}" => "public/screens##{name}"
  end


     constraints CanAccessResque do
             mount Resque::Server, at: 'resque'
                 end



  # Backdoors used in test and development
  match "/enter/:id" => "public/sessions#enter", :as => :enter unless Rails.env.production?
  match "/gocamp/:id" => "admin/camps#enter", :as => :gocamp unless Rails.env.production?

end

