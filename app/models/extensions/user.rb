module Extensions
  module User
    extend ActiveSupport::Concern

    included do
      include Extensions::Roles
    end
  end
end

