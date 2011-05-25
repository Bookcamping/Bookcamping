class BookList < ActiveRecord::Base
  belongs_to :user
  has_many :books
  acts_as_list

  validates :user_id, :presence => true
  validates :name, :presence => true

  has_paper_trail :meta => {
       :title => Proc.new {|list| list.title},
       :user_name => Proc.new{|list| list.user.name}
   }

  def title
    "#{self.position - 1}.- #{name}"
  end

end
