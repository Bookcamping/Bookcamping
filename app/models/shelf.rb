class Shelf < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user
  has_many :shelf_items, :dependent => :destroy
  has_many :books, :through => :shelf_items

  has_paper_trail :meta => {
      :title => Proc.new { |shelf| shelf.name },
      :camp_id => Proc.new { |shelf| shelf.camp_id },
      :user_name => Proc.new { |shelf| shelf.user.name }
  }


  validates :camp_id, :presence => true
  validates :user_id, :presence => true

  COLORS = ['#db533d', '#86475e', '#afa9ad', '#e9c54b', '#64a353',
              '#c36d3b', '#ee8587', '#357391', '#67c095', '#4eaea8', '#f15a5b',
              '#44adc6', '#9a7fba', '#264c51']


  def add_book(book, user)
    ShelfItem.create!(:shelf_id => self.id, :book_id => book.id, :user_id => user.id)
  end

  def background
    color? ? color : 'black'
  end

  def to_param
    limited = name.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end

end
