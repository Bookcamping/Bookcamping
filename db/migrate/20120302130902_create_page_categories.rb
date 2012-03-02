# encoding: utf-8
class CreatePageCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, limit: 64
      t.string :slug, limit: 64
      t.string :description, limit: 300
      t.string :section, limit: 32
      t.string :view_level, limit: 16
      t.string :edit_level, limit: 16
      t.timestamps
    end
    add_index :categories, :slug

    remove_column :pages, :view_level
    remove_column :pages, :edit_level
    remove_column :pages, :category
    add_column :pages, :category_id, :integer

    public = Category.create(name: 'Páginas públicas', view_level: :public, edit_level: :public)
    Category.create(name: 'Administración', view_level: :public, edit_level: :admin)
    Category.create(name: 'Sobre licencias', view_level: :public, edit_level: :public, section: 'licenses')
    Category.create(name: 'Documentos de trabajo', view_level: :admin, edit_level: :admin)

    Page.update_all(category_id: public.id)
  end
end
