class MergeDuplicatedUsersAgain < ActiveRecord::Migration
  def up
    PaperTrail.enabled = false

    roger = User.find 536
    merge_user roger, 537
    merge_user roger, 614

    sfoixv = User.find 538
    merge_user sfoixv, 541
    merge_user sfoixv, 539
    merge_user sfoixv, 540

    laura = User.find 552
    merge_user laura, 553
    merge_user laura, 568

    pablo = User.find 569
    merge_user pablo, 570

    leticia = User.find 584
    merge_user leticia, 585

    roger = User.find 536
    merge_user roger, 537
    merge_user roger, 614

    zulo = User.find 560
    merge_user zulo, 757

    juan = User.find 1033
    merge_user juan, 1034

    laura = User.find 529
    merge_user laura, 1315

    monica = User.find 1385
    merge_user monica, 1386

    angeles = User.find 1403
    merge_user angeles, 1404


  end

  def down
  end

  def merge_user(user, id) 
    dup = User.find_by_id id
    return if dup.blank?
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

    dup.destroy
    user.save(validate: false)


  end
end
