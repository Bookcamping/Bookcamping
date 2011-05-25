class BookList < ActiveRecord::Base
  belongs_to :user
  has_many :books
  acts_as_list

  has_paper_trail

  def title
    "#{self.position - 1}.- #{name}"
  end

end
