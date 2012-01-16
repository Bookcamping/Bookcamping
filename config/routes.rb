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
        resources :taggings
      end
    end

    resources :tags
    resources :versions, path: 'actividad'

    scope module: 'licenses' do
      resources :licenses, path: 'licencias'
    end 

    scope module: 'public' do
      resources :password_recoveries, path: 'recuperar' do
        post :change, on: :collection
      end
    end

    match '/recuperar/token/:id' => 'public/password_recoveries#recover', as: 'recovery'

    namespace :personal, path: 'mis' do
      root to: redirect('/mis/labores')
      resource :user, path: 'datos'
      resources :books, path: 'referencias'
      resources :user_shelves, path: 'listas' do
        post :bulk_add, on: :collection
      end
      resources :profile_shelves, path: 'marcas'
    end


    scope module: 'social' do
      resources :users, path: 'somos', only: [:index, :show, :search] do
        get :search, on: :collection, path: 'buscar'

        resources :versions, path: 'actividad'
        resources :user_shelves, path: 'listas', only: [:index, :show] do
          resources :books, path: 'referencias', only: [:show, :index]
        end
      end
      resource :explorer, path: 'explorar', only: [:show]
    end

    scope module: 'services' do
      resources :notices, only: [:index]
    end

  end

  scope module: 'blog' do
    resources :posts, path: 'blog' do
      resources :comments
    end
    resources :media_bites, path: 'media'
    #Mercury::Engine.routes
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


  namespace :backend do
    root to: 'stats#show'
    resource :stats
    [:licenses, :books, :users, :posts, :shelves, :versions, :identities, :activities].each do |name|
      resources name do
        get :search, on: :collection
      end
    end
  end

  match "/clismon/pnh" => 'publishers/clismon#pnh'


  match "/listas" => redirect("/estanterias")
  match "/listas/:id" => redirect("/estanterias/%{id}")
  match "/libros/:id" => redirect("/referencia/%{id}")
  match "/lista/:id" => redirect("/estanteria/%{id}")


  match "/identificar" => "public/sessions#create"
  match "/entrar" => "public/sessions#new", as: :login
  match "/auth/:provider/callback" => "public/sessions#create_with_omniauth"
  match "/salir" => "public/sessions#destroy", :as => :logout
  match "/entrar/:id" => "public/sessions#new", :as => :auth
  match "/auth/failure" => "public/sessions#failure"

  match "/buscar/:term" => "references/books#search", :as => :search
  match "/buscar" => "references/books#search"

  ['mapa', 'cuatrocientoscuatro', 'quinientos'].each do |name|
    match "/#{name}" => "public/screens##{name}"
  end

  # Backdoors used in test and development
  match "/enter/:id" => "public/sessions#enter", :as => :enter unless Rails.env.production?
  match "/gocamp/:id" => "admin/camps#enter", :as => :gocamp 

end

