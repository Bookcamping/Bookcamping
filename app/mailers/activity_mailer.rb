class ActivityMailer < ActionMailer::Base
  layout 'mail'
  default_url_options[:host] = "bookcamping.cc"
  default from: 'app@bookcamping.cc'
  
  def last_site_activity(camp_id, user_id)
    @camp = Camp.find camp_id
    @versions = @camp.versions.order('id DESC').limit(50)
    @user = User.find user_id
    mail to: @user.email, subject: "Actividad en ##{@camp.name}"
  end
end

    
