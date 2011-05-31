class Comment < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  belongs_to :camp
  belongs_to :user

  after_create :update_comments_count

  has_paper_trail :meta => {
      :title => Proc.new {|comment| comment.resource.title}
  }


  scope :direct, :conditions => where(:ancestry => nil)

  validates :resource_id, :presence => true
  validates :resource_type, :presence => true
  validates :body, :presence => true
  validates :camp_id, :presence => true

  protected
  def update_comments_count
    PaperTrail.enabled = false
    self.resource.update_attribute(:comments_count, self.resource.comments_count + 1)
    PaperTrail.enabled = true
  end

end
