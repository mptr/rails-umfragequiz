require 'jwt'
require "http"

class ApplicationController < ActionController::API
	before_action :check_auth
	@requester_email = nil
	@requester_username = nil

	def require_requester_to_be(u)
		render nothing: true, status: 403 and return true if u.email != @requester_email
	end

	def check_auth
		# decode middle jwt part
		# if iss == 'google'
		# validation with google
		# else if iss == 'microsoft'
		# validation with microsoft
		# else
		# reject w 403

		token = request.headers['HTTP_AUTHORIZATION']&.split(' ')

		# fake token if in dev or test environment
		if Rails.env == 'development' || Rails.env == 'test'
			if token&.second == 'magically-generated'
				@requester_username = token.third
				@requester_email = token.fourth
				return
			end
		end

		token = token&.second

		# kein Token
		if token.nil?
			render nothing: true, status: 403
			return
		end

		begin # first try with google token
			decoded_token = validate_token(token, 'google')
			@requester_email = decoded_token['email']
			@requester_username = decoded_token['name']
		rescue JWT::DecodeError => eg
			begin # then try with microsoft token
				decoded_token = validate_token(token, 'microsoft')
				@requester_email = decoded_token['email']
				@requester_username = decoded_token['name']
			rescue JWT::DecodeError => em # both failed => 403
				puts "Could not decode token: #{eg}    #{em}"
				render nothing: true, status: 403
			end
		end
	end

	private
	JWT_CONFIG = {
		'google' => {
			'aud' => '709962217448-ecjl8ic8hafu4sbu14l11tefrg927jmi.apps.googleusercontent.com',
			'jwks_url' => 'https://www.googleapis.com/oauth2/v3/certs'
		},
		'microsoft' => {
			'aud' => 'b919ee48-9933-4631-8669-9d04662da439',
			'jwks_url' => 'https://login.microsoftonline.com/common/discovery/v2.0/keys'
		}
	}

	@@jwks_cache = {} # cache jwks until server restart
	def fetch_jwks(url)
		if @@jwks_cache[url].nil?
			res = HTTP.get(url)
			@@jwks_cache[url] = JSON.parse(res.body)
		end
		return @@jwks_cache[url]
	end
	def validate_token(token, kind)
		JWT.decode(
			  token,
			  nil,
			  true, # Verify the signature of this token
			  algorithms: ["RS256"],
			  verify_iss: false,
			  aud: JWT_CONFIG[kind]['aud'],
			  verify_aud: true,
			  jwks: fetch_jwks(JWT_CONFIG[kind]['jwks_url']),
		)[0]
	end
end
