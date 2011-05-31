class AppController < ApplicationController
  expose(:library) { Library.new(current_camp, current_user) }

  def app

  end

  LIMIT = 20
  expose(:ultimas_books) { current_camp.books.order('id DESC').limit(LIMIT) }
  expose(:comentadas_books) { current_camp.books.where('comments_count > 0').order('comments_count DESC').limit(LIMIT) }
  expose(:valoradas_books) { current_camp.books.where('like_it_marks > 0').order('like_it_marks DESC').limit(LIMIT) }
  expose(:deseadas_books) { current_camp.books.where('read_later_marks > 0').order('read_later_marks DESC').limit(LIMIT) }

  def lists
    if ['ultimas', 'comentadas', 'valoradas', 'deseadas'].include? params[:id]
      books = self.send "#{params[:id]}_books"
      name = I18n.t("app.lists.#{params[:id]}").html_safe
      render_grid name, books
    else
      render :text => 'Lista no encontrada'
    end
  end

  def sections
    if ['bookcamping', 'videocamping', 'listas', 'libreria'].include? params[:id]
      render "section_#{params[:id]}", :layout => false
    else
      render :text => params[:id]
    end
  end
end