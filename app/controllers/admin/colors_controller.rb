class Admin::ColorsController < Admin::ResourceController
  expose(:colors) { Color.all }
  expose(:color)

  def index

  end

  def update
    update! { admin_colors_path }
  end

  def create
    create! { admin_colors_path }
  end

end

