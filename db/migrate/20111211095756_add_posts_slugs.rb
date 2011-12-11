class AddPostsSlugs < ActiveRecord::Migration
  def up
    add_column :posts, :slug, :string, limit: 200
    change_column :posts, :title, :string, limit: 200
    remove_column :posts, :camp_id

    Post.all.each do |post|
      if post.visibility == 'public'
        post.visibility = 'published'
      else
        post.visibility = 'draft'
      end
      post.slug = post.title.parameterize
      post.save
    end 
  end

  def down
    remove_column :posts, :slug
    add_column :posts, :camp_id

    Post.update_all(:camp_id => 1)
  end
end
