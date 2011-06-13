class AutoShelf < ActiveRecord::Base

  NAMES =  [:ultimas, :comentadas, :valoradas, :deseadas]

  def self.find(name)
    NAMES.include?(name.to_sym) ? AutoShelf.new(name.to_sym) : nil
  end

  def initialize(name)
    @name = name
  end


  LIMIT = 20
  expose(:ultimas_books) { current_camp.books.order('id DESC').limit(LIMIT) }
  expose(:comentadas_books) { current_camp.books.where('comments_count > 0').order('comments_count DESC').limit(LIMIT) }
  expose(:valoradas_books) { current_camp.books.where('like_it_marks > 0').order('like_it_marks DESC').limit(LIMIT) }
  expose(:deseadas_books) { current_camp.books.where('read_later_marks > 0').order('read_later_marks DESC').limit(LIMIT) }
  def show_generated
    if NAMES.include? params[:id]
      books = self.send "#{params[:id]}_books"
      name = I18n.t("app.lists.#{params[:id]}").html_safe
    else
      render :text => 'Lista no encontrada'
    end
  end

end
