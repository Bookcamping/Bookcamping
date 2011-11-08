# User
#
#create_table "users", :force => true do |t|
#  t.string   "name" REQUIRED
#  t.string   "provider"
#  t.string   "uid"
#  t.string   "email"
#  t.string   "rol",           :limit => 10
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.integer  "login_count",                 :default => 0
#  t.datetime "last_login_at"
#end
class User < ActiveRecord::Base
  has_many :book_lists
  has_many :books
  has_many :memberships
  has_many :user_shelves


  validates :name, presence: true

  def profile_shelves(camp)
    ProfileShelf.where(:user_id => self.id).where(:camp_id => camp.id)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
    end
  end

  def super?
    self.rol == 'super'
  end

  def admin?
    self.rol == 'admin' || self.rol == 'super'
  end

  def membership(camp)
    @membership ||= Membership.find_or_create_by_user_id_and_camp_id(self.id, camp.id)
  end
end
