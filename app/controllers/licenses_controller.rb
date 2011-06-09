class LicensesController < ApplicationController
  expose(:licenses) { License.all }
  expose(:license)

  def index

  end

end
