class AddContentTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :content_type, :string, limit: 32

    Post.all.each do |post|
      post.update_attribute(:content_type, :markdown)
    end
  end
end
