class License < ActiveRecord::Base
  has_many :books

  def license_type
    if self.id == 1
      'unknown'
    elsif self.id == 8
      'pd'
    elsif self.id == 9
      'copyright'
    else
      'cc'
    end
  end

end
