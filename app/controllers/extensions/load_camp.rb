module Extensions
  module LoadCamp
    extend ActiveSupport::Concern

    module InstanceMethods
      protected
      def load_camp_from_request
        if request.domain == 'videocamping.cc'
          session[:camp_id] = 2
        elsif request.subdomain.present? and (request.subdomain == 'escucha' or request.subdomain == 'escuchamos')
          session[:camp_id] = 3
        end
        session[:camp_id] ||= 1
        Camp.find session[:camp_id]
      end
    end
  end
end

