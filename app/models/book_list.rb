class BookList < ActiveRecord::Base
  belongs_to :user
  has_many :books
  acts_as_list

  def title
    "#{self.position - 1}.- #{name}"
  end

end
