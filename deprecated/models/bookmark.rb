class Bookmark < ActiveRecord::Base
  belongs_to :reference
  belongs_to :user
  belongs_to :camp

  scope :previous, lambda {|name, user_id| where({:name => name, :user_id => user_id})}
  scope :like_it, where(:name => 'like_it')
  scope :read_later, where(:name => 'read_later')

  validates :reference_id, :presence => true
  validates :user_id, :presence => true
  validates :camp_id, :presence => true
  validates :name, :presence => true
  attr_accessor :count, :message

  has_paper_trail :meta => {
      :title => Proc.new { |referencemark| referencemark.reference.title }
  }


  NAMES = [:like_it, :read_later]

  after_create do
    PaperTrail.enabled = false
    self.reference.update_referencemark(self.name, 1)
    PaperTrail.enabled = true
  end

  after_destroy do
    PaperTrail.enabled = false
    self.reference.update_referencemark(self.name, -1)
    PaperTrail.enabled = true
  end

  def to_json(options = {})
    {:count => count, :name => name, :message => message, :reference_id => reference_id}.to_json
  end
end
