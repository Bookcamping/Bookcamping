

class CanAccessResque
  def self.matches?(request)
    request.session[:user_id] == 4
  end
end