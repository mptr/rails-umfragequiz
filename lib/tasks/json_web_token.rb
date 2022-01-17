class JsonWebToken
    def self.rsa_key
        url = URI.parse(url_var)
        key_file = JSON.parse(Net::HTTP.get(url))
        x5c = Base64.decode64(json_to_key(key_file))
        OpenSSL::X509::Certificate.new(x5c).public_key
    end
  
    def self.decode(token)
        JWT.decode(token, rsa_key, true, { 
            algorithm: 'RS256', 
            iss: iss_var, 
            verify_iss: true 
            }
        )
    end
end