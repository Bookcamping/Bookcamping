class AddInfoToLicenses < ActiveRecord::Migration
  def change
    add_column :licenses, :body, :text
    add_column :licenses, :references_count, :integer
    add_column :licenses, :image_url, :string, limit: 200
    add_column :licenses, :slug, :string, limit: 300
    add_column :licenses, :reference_url, :string, limit: 200

    License.all.each do |license|
      license.references_count = license.references.count
      license.save
    end
  end
end
