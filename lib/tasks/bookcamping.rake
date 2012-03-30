namespace :bookcamping do
  task merge_user: :environment do
    user = User.find ENV['USER']
    id = ENV['DUP']

    puts "Merge #{user.name} with #{id}"
    dup = User.find_by_id id

    if dup.present?
      user.email ||= dup.email
      user.twitter ||= dup.twitter
      user.description ||= dup.description
      user.password_digest ||= dup.password_digest
      user.uid_twitter ||= dup.uid_twitter
      user.uid_facebook ||= dup.uid_facebook
      user.uid_google ||= dup.uid_google
      Reference.where(user_id: id).update_all(user_id: user.id)
      ShelfItem.where(user_id: id).update_all(user_id: user.id)
      Shelf.where(user_id: id).update_all(user_id: user.id)
      Comment.where(user_id: id).update_all(user_id: user.id)
      Membership.where(user_id: id).update_all(user_id: user.id)
      Tagging.where(user_id: id).update_all(user_id: user.id)
      Version.where(whodunnit: id).update_all(whodunnit: user.id)

      dup.destroy
      user.save(validate: false)
      puts "#{user.name} merged!"
    else
      puts "User with id #{id} not found"
    end
  end
end
