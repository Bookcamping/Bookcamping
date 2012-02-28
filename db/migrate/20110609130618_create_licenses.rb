# encoding: utf-8
class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.string :name, :limit => 300
      t.string :url, :limit => 500
      t.string :icon, :limit => 300
      t.boolean :open
      t.timestamps
    end

    add_column :references, :license_id, :integer

    License.create(:name => 'No lo se', :url => '', :icon => '', :open => false)

    License.create(:name => 'Creative commons CC BY-NC-ND (Reconocimiento/NoComercial/SinObraDerivada',
                   :url => 'http://creativecommons.org/licenses/by-nc-nd/3.0',
                   :icon => 'http://upload.wikimedia.org/wikipedia/commons/0/03/CC-BY-NC-ND-icon-80x15.png',
                   :open => true)

    License.create(:name => 'Creative commons CC BY-NC-SA (Reconocimiento/NoComercial/CompartirIgual)',
                   :url => 'http://creativecommons.org/licenses/by-nc-sa/3.0',
                   :icon => 'http://upload.wikimedia.org/wikipedia/commons/1/1f/CC-BY-NC-SA-icon-80x15.png',
                   :open => true)

    License.create(:name => 'Creative commons CC BY-NC (Reconocimiento/NoComercial)',
                   :url => 'http://creativecommons.org/licenses/by-nc/3.0',
                   :icon => 'http://upload.wikimedia.org/wikipedia/commons/b/bc/CC-BY-NC-icon-80x15.png',
                   :open => true)

    License.create(:name => 'Creative commons CC BY-ND (Reconocimiento/SinObraDerivada)',
                   :url => 'http://creativecommons.org/licenses/by-nd/3.0',
                   :icon => 'http://upload.wikimedia.org/wikipedia/commons/8/8e/CC-BY-ND-icon-80x15.png',
                   :open => true)

    License.create(:name => 'Creative commons CC BY-SA (Reconocimiento/CompartirIgual)',
                   :url => 'http://creativecommons.org/licenses/by-sa/3.0',
                   :icon => 'http://upload.wikimedia.org/wikipedia/commons/9/96/CC-BY-SA-icon-80x15.png',
                   :open => true)

    License.create(:name => 'Creative commons CC BY (Reconocimiento)',
                   :url => 'http://creativecommons.org/licenses/by/3.0',
                   :icon => 'http://upload.wikimedia.org/wikipedia/commons/b/b1/CC-BY-icon-80x15.png',
                   :open => true)

    License.create(:name => 'Dominio público', :url => 'http://es.wikipedia.org/wiki/Dominio_p%C3%BAblico',
      :icon => '/assets/pd16.png', :open => true)

    License.create(:name => 'Copyright', :url => 'http://en.wikipedia.org/wiki/Copyright',
      :icon => '/assets/cr16.png', :open => false)

  end
end
