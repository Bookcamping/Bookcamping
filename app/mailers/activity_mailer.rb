class ActivityMailer < ActionMailer::Base
  layout 'mail'
  default_url_options[:host] = "bookcamping.cc"
  default from: '#bookcamping <hola@bookcamping.cc>'
  
  def site_activity(last_email_at)
    @last_email_at = last_email_at
    @versions = Site.site_activity(last_email_at)
    mail to: 'bookcamping@googlegroups.com', subject: "#bookcamping: Actividad"
  end

  def activity_email(version_id)
    @version = Version.find version_id
    title = "[#bookcamping] Actividad en '#{@version.title}'"
    @host = Rails.env.production? ? 'http://bookcamping.cc' : 'localhost:3000'
    mail to: 'hola@bookcamping.cc', subject: title
  end 
end

    
