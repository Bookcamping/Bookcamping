# License
#
#create_table "licenses", :force => true do |t|
#  t.string   "name",       :limit => 300 REQUIRED
#  t.string   "url",        :limit => 500
#  t.string   "icon",       :limit => 300
#  t.boolean  "open"
#  t.datetime "created_at"
#  t.datetime "updated_at"
#end
class License < ActiveRecord::Base
  extend FriendlyId

  # EXTENSIONS
  friendly_id :name, use: :slugged
  has_paper_trail meta: {title: :name }


  # RELATIONS
  has_many :references, dependent: :restrict

  # VALIDATIONS
  validates :name, presence: true

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

  def libre?
    self.id != 1 and self.id != 9
  end

end
