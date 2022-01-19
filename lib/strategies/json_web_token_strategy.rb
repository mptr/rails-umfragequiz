require '../google_json_web_token'

class JsonWebTokenStrategy < ::Warden::Strategies::Base
    def valid?
      token
    end
  
    def authenticate!
      if claims
        success! claims
      else
        fail!
      end
    end
  
    def claims
      ::GoogleJsonWebToken.decode(token)[0]
    rescue
      nil
    end
  
    def token
      unless request.env['HTTP_AUTHORIZATION'].nil?
        request.env['HTTP_AUTHORIZATION'].split(' ').last
      end
    end
  end