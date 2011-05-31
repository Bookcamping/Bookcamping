class AppController < ApplicationController
  expose(:library) { Library.new(current_camp, current_user) }
  def app

  end

  def section

  end
end