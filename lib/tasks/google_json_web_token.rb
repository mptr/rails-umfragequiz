class GoogleJsonWebToken < JsonWebToken
    def self.iss_var
        "accounts.google.com"
    end

    def self.url_var
        "https://www.googleapis.com/oauth2/v1/certs"
    end

    def self.json_to_key(json)
        json["ca00620c5aa7be8cd03a6f3c68406e45e93b3cab"]
    end
end
