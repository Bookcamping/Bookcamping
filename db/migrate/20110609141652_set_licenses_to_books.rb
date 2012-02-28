# encoding: utf-8

class SetLicensesToBooks < ActiveRecord::Migration
  def up

    License.find(1).update_attributes(:name => 'No se qué licencia tiene',
      :url => 'http://es.wikipedia.org/wiki/Licencia', :icon => '/assets/desconocida.png', :open => false)

    Reference.all.each do |reference|
      reference.update_attribute(:license_id, 1) unless reference.license_id?
    end

  end

  def down
  end
end
