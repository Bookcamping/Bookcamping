module HasRoles
    extend ActiveSupport::Concern

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

