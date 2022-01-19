class GoogleJsonWebToken < JsonWebToken
    def self.iss_var
        "https://login.microsoftonline.com/9188040d-6c67-4c5b-b112-36a304b66dad/v2.0"
    end

    def self.url_var
        "https://login.microsoftonline.com/common/discovery/keys"
    end

    def self.json_to_key(json)
        json['keys'][0]['x5c'][0]
    end
end

