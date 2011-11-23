

class CanAccessResque
  def self.matches?(request)
    request.session[:user_id] == 2
  end
end
