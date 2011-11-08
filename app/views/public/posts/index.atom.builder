atom_feed :language => 'es-ES' do |feed|
  feed.title '#bookcamping blog'
  feed.updated posts.first.updated_at

  posts.each do |post|
    feed.entry(post) do |entry|
      entry.title post.title
      entry.content markdown(post.render_body), :type => 'html'
      entry.author do |author|
        author.name post.author
      end
    end
  end
end