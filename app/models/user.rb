class User < ActiveRecord::Base
  has_many :book_lists
  has_many :books
  has_many :memberships

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
