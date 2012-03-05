class MergeDuplicatedUsers < ActiveRecord::Migration
  def up

    PaperTrail.enabled = false
    Comment.all.each do |comment|
      comment.update_attribute(:resource_type, 'Reference') if comment.resource_type == 'Book'
    end

    # Silvink
    silvink = User.find 1
    dup = User.find_by_id 489
    if dup.present?
      silvink.password_digest = dup.password_digest
      silvink.email = dup.email
      dup.destroy
      silvink.save!
    end

    # María Castelló
    maria = User.find 455
    dup = User.find_by_id 549
    dup.destroy if dup.present?
    dup = User.find_by_id 547
    dup.destroy if dup.present?
    dup = User.find_by_id 575
    if dup.present?
      maria.uid_google = dup.uid_google
      maria.email = dup.email
      dup.references.each do |ref|
        ref.update_attribute(:user_id, maria.id)
      end
      dup.reload
      dup.destroy
      maria.save
    end

    # Jess
    jess = User.find 546
    dup = User.find_by_id 589
    if dup.present?
      jess.email = dup.email
      jess.uid_google = dup.uid_google
      dup.destroy
      jess.save
    end
    dup = User.find_by_id 660
    if dup.present?
      jess.uid_twitter = dup.uid_twitter
      dup.destroy
      jess.save
    end
  end

  def down
  end
end
