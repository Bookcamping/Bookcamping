module LoadCamp
  extend ActiveSupport::Concern

  protected
  def load_camp_from_request
    camp = Camp.find_by_host(request.host)
    if camp.present?
      session[:camp_id] = camp.id
    else
      session[:camp_id] ||= 1
    end
    Camp.find session[:camp_id]
  end

  def load_camp_from_request_old
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

