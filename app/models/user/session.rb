class User::Session

  def initialize(auth)
    @auth = auth
  end

  def create
    if omniauth?
      @user = find_with_omniauth
      @user ||= create_with_omniauth
      @user.email= @auth["user_info"]["email"]
      add_twitter_information
      add_email_information
    else

    end

    audit_user if @user.present?
    @user.present?
  end

  def user
    @user
  end

  protected
  def omniauth?
    @auth["provider"].present?
  end

  def find_with_omniauth
    uid = @auth['uid']
    case @auth['provider']
      when 'twitter'
        User.find_by_twitter_uid(uid)
      when 'facebook'
        User.find_by_facebook_uid(uid)
      when 'google'
        User.find_by_google_uid(uid)
    end
  end

  def create_with_omniauth
    User.create! do |user|
      user.provider = @auth["provider"]
      user.uid = @auth["uid"]
      user.name = @auth["user_info"]["name"]
    end
  end

  def audit_user
    @user.last_login_at = Time.now
    @user.login_count ||= 0
    @user.login_count = user.login_count + 1
    @user.save(:validate => false)
  end

  def add_twitter_information
    if @user.twitter.blank? and @auth['provider'] == 'twitter'
      @user.twitter = @auth['user_info']['nickname']
    end
  end

  def add_email_information
    if @user.email.blank? and @auth['user_info']['email'].present?
      @user.email = @auth['user_info']['email']
    end
  end
end

