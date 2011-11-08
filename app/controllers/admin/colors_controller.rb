class Admin::ColorsController < Admin::ResourceController
  expose(:colors) { Color.all }
  expose(:color)

  def index

  end

end

