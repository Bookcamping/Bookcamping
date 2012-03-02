class AddCategoryToWikiAndLicensesWithBodyAgain < ActiveRecord::Migration
  def change
    add_column :licenses, :body, :string
    remove_column :licenses, :reference_url
    remove_column :licenses, :page_id

    add_column :pages, :category, :string, :limit => 16
  end
end
