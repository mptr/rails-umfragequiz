class ApplicationController < ActionController::API
  before_action :check_auth
  @requester_email = nil
  @requester_username = nil

  def check_auth
    # decode middle jwt part
    # if iss == 'google'
      # validation with google
    # else if iss == 'microsoft'
      # validation with microsoft
    # else
      # reject w 403

    token = request.headers['HTTP_AUTHORIZATION']&.split(' ')&.second

    # kein Token
    if token.nil? then
      render :nothing => true, :status => 403
      return
    end

    validator = GoogleIDToken::Validator.new
    begin
      payload = validator.check(token, "709962217448-ecjl8ic8hafu4sbu14l11tefrg927jmi.apps.googleusercontent.com")
      puts payload
      @requester_email = payload['email']
      @requester_username = payload['name']
    rescue GoogleIDToken::ValidationError => e
      puts "Cannot validate: #{e}"
      render :nothing => true, :status => 403
    end
  end
end
