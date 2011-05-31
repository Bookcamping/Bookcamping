class Bookmark < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  belongs_to :camp

  scope :previous, lambda {|name, user_id| where({:name => name, :user_id => user_id})}
  scope :like_it, where(:name => 'like_it')
  scope :read_later, where(:name => 'read_later')

  validates :book_id, :presence => true
  validates :user_id, :presence => true
  validates :camp_id, :presence => true
  validates :name, :presence => true
  attr_accessor :count, :message

  NAMES = [:like_it, :read_later]

  after_create do
    self.book.update_bookmark(self.name, 1)
  end

  after_destroy do
    self.book.update_bookmark(self.name, -1)
  end

  def to_json(options = {})
    {:count => count, :name => name, :message => message, :book_id => book_id}.to_json
  end
end
