module Extensions
  module Roles
    extend ActiveSupport::Concern

    module ClassMethods
    end


    def super?
      self.rol == 'super'
    end

    def admin?
      super? || rol == 'admin'
    end

    def beta?
      admin? || rol == 'beta'
    end


  end
end

