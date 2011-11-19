class Publishers::ClismonController < ApplicationController
  expose(:current_publisher) { 'clismon' }
  expose(:book) { Book.find 1300 }
  def pnh

  end
end

