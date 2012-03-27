module LoadCamp
  extend ActiveSupport::Concern

  protected
  def load_camp_from_request
    puts "HOST #{request.host}"
    if request.domain == 'videocamping.cc'
      session[:camp_id] = 2
    elsif request.subdomain.present? and (request.subdomain == 'escucha' or request.subdomain == 'escuchamos')
      session[:camp_id] = 3
    end
    session[:camp_id] ||= 1
    Camp.find session[:camp_id]
  end
end

