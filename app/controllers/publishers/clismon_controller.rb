class Publishers::ClismonController < ApplicationController
  expose(:current_publisher) { 'clismon' }
  expose(:reference) { Reference.find 1300 }
  def pnh

  end
end

