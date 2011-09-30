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
        root_path

      # REFERENCE
      when /^"(.*)" reference page$/i
        book_path(Book.find_by_title($1))

      when /^new reference page$/
        new_book_path

      # SECTION
      when /^"([^"]*)" camp's shelf page$/i
        camp_shelf_path(CampShelf.find_by_name!($1))

      when /^"([^"]*)" at "([^"]*)" camp's shelf page$/i
        book = Book.find_by_title!($1)
        section = CampShelf.find_by_name!($2)
        camp_shelf_book_path(section, book)

      when /^camp's shelves page$/
        camp_shelves_path

      when /^new camp shelf page$/
        new_camp_shelf_path

      # POSTS
      when /^posts page$/
        posts_path

      when /^"([^"]*)" post page$/i
        post_path(Post.find_by_title!($1))

    # ADMIN
      # MEDIA
      when /^admin media list page$/
        admin_media_bites_path

      when /^new admin media page$/
        new_admin_media_bite_path

      when /^"([^"]*)" admin media page$/i
        admin_media_bite_path(MediaBite.find_by_title!($1))

      # POSTS
      when /^admin posts page$/
        admin_posts_path

      when /^new admin post page$/
        new_admin_post_path

      when /^"([^"]*)" admin post page$/i
        admin_post_path(Post.find_by_title!($1))

      when /^edit "([^"]*)" admin post page$/i
        edit_admin_post_path(Post.find_by_title!($1))

      # CAMP SHELVES
      when /^admin camp shelves page$/
        admin_camp_shelves_path

      # CURATED SHELVES
      when /^admin curated shelves page$/
        admin_curated_shelves_path



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
