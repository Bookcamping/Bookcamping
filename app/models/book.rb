class Book < ActiveRecord::Base
  belongs_to :book_list
  belongs_to :user
  has_many :comments, :as => :resource , :order => 'id DESC'

   has_paper_trail :meta => {
       :title => Proc.new {|book| book.title},
       :user_name => Proc.new{|book| book.user.name}
   }

  attr_accessible :description, :book_list_id, :title, :authors, :editor, :url
  attr_accessible :user_id, :as => :super

  validates :book_list_id, :presence => true
end
