class Book < ActiveRecord::Base
  belongs_to :book_list
  belongs_to :user
  has_many :comments, :as => :resource, :order => 'id DESC'
  has_many :shelf_items, :include => :shelf
  has_many :shelves, :through => :shelf_items

  scope :titled, where('title != null')

  has_paper_trail :meta => {
      :title => Proc.new { |book| book.title },
      :user_name => Proc.new { |book| book.user.name }
  }

  attr_accessible :description, :book_list_id, :title, :authors, :editor, :url, :date
  attr_accessible :user_id, :as => :super

  validates :user_id, :presence => true

  def book_title
    if self.title.present?
      self.title
    else
      match = /\*(.*)\*/.match(description)
      if match
        match[1]
      else
        match = /^([a-zA-Z\s^,]*),/.match(description)
        match ? match[1] : ''
      end
    end
  end

  def clean_description
    if self.title.present?
      self.description
    else
     title = book_title
      if title.present?
        d = description[title.size+2..-1]
        d.gsub(/^,\s*/, '') if d.present?
      else
        description
      end
    end
  end

end
