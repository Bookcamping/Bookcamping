module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

      # HOME
      when /^the home\s?page$/
        '/'

      # REFERENCE
      when /^"(.*)" reference page$/i
        book_path(Book.find_by_title($1))

      when /^new reference page$/
        new_book_path

      # SECTION
      when /^"([^"]*)" section page$/i
        shelf_path(Shelf.find_by_name($1))

      when /^"([^"]*)" at "([^"]*)" section page$/i
        book = Book.find_by_title!($1)
        section = Shelf.find_by_name!($2)
        shelf_book_path(section, book)

      when /^sections page$/
        shelves_path

      when /^new section page$/
        new_shelf_path

      # POSTS
      when /^posts page$/
        posts_path

      when /^new post page$/
        new_post_path

      when /^"([^"]*)" post page$/i
        post_path(Post.find_by_title!($1))

      when /^edit "([^"]*)" post page$/i
        edit_post_path(Post.find_by_title!($1))

      # MEDIA
      when /^media list page$/
        media_path

      # BACKEND
      when /^backend references$/
        backend_books_path

      else
        begin
          page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue NoMethodError, ArgumentError
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                    "Now, go and add a mapping in #{__FILE__}"
        end
    end
  end
end

World(NavigationHelpers)
