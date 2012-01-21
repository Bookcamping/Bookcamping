class AddLangAndPropertiesToCamp < ActiveRecord::Migration
  def change
    add_column :camps, :lang, :string, limit: 8
    add_column :camps, :settings, :text

    Camp.update_all(lang: 'es')
  end
end
