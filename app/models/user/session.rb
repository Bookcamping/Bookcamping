class User::Session

  def initialize(auth)
    @attrs = {}
    if auth['provider'].present?
      @provider = auth['provider']
      @uid = auth['uid']
      @attrs["#{@provider}_uid".to_sym] = @uid
      @attrs[:name] = auth['user_info']['name']
      @attrs[:email] = auth['user_info']['email']
    else
      @provider = nil
      @uid = nil
      if auth['name'].include? '@'
        @attrs[:name] = auth['name']
      else
        @attrs[:email] = auth['name']
      end
    end
  end

  def user_attributes
    @attrs
  end

  def create_user?
    @provider.present? and @user.nil?
  end


  def create
    @user = nil
    if @provider
      @user = find_with_omniauth
#      @user ||= create_with_omniauth
#      @user.email= auth["user_info"]["email"]
#      add_twitter_information
#      add_email_information
    else
      @user = find_with_params
    end

#    SetupUser.new(@user).create_profile_shelves if new_user?
#    audit_user if @user.present?
    @user.present?
  end

  def user
    @user
  end

  protected
  def omniauth?
    auth["provider"].present?
  end

  def find_with_params
    user = User.find_by_name(auth[:name])
    user ||= User.find_by_email(auth[:name])
    if user
      @user = user if user.authenticate(auth[:password])
    else
      nil
    end
  end

  def find_with_omniauth
    case @provider
      when 'twitter'
        User.find_by_twitter_uid(@uid)
      when 'facebook'
        User.find_by_facebook_uid(@uid)
      when 'google'
        User.find_by_google_uid(@uid)
    end
  end

  def create_with_omniauth
    User.new do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
    end
    @new_user = true
  end

end

